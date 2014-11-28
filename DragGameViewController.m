//
//  DragGameViewController.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-20.
//  Copyright (c) 2014 ajek. All rights reserved.
//

/////////////Note: Current maximum number of sound options is 10

#import "DragGameViewController.h"

@interface DragGameViewController ()

@end

@implementation DragGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.buttonsArray = [NSMutableArray new];
//    [self setPhonemeCounter];
    [self setUpAndGetReadyToPlay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpAndGetReadyToPlay {
    [self setPhonemeCounter];
    [self setUpGameSounds];
    [self removeColorBlockOptions];
    [self removeWordButtons];
    [self generateAndDisplayWord];
    [self makeColorBlockOptions];
//    self.gameOverButton.hidden = YES;
    self.placeInPhonemeArray = 0;
    self.nextWordButton.hidden = YES;
}

-(void)setPhonemeCounter {
    self.phonemesToMatch = 0;
    self.phonemesCounter = 1;
}

-(void)removeColorBlockOptions {
    for (DragColorView *dragColorView in self.colorBlocksArray) {
        [dragColorView removeFromSuperview];
    }
    [self.colorBlocksArray removeAllObjects];
}

-(void)removeWordButtons{
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
}

- (void)generateAndDisplayWord {
    NSArray * wordArray = [[[WordLibrary sharedLibrary] wordLibrary] allValues];
    self.currentWord = wordArray[arc4random_uniform((u_int32_t)wordArray.count)];
    self.phonemesToMatch = (u_int32_t)self.currentWord.phonemeArray.count;
    [self createButtonForWord:self.currentWord];
}

-(void) createButtonForWord:(Word*)word {
    UIButton *lastButton;
    for (Phoneme *phoneme in word.phonemeArray) {
        UIButton *justMadeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justMadeButton setTagString:phoneme.soundIdentifier];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:phoneme.letters attributes:@{
                                                                                                                       NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize]}];
        [justMadeButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
        if (lastButton ==nil) {
            //first button/phoneme of the word is placed at X half of the word's width leftwards from half of the screen's width (so the word is centered) - its Y is at half of the frame's height minus half of the phoneme's stringSize height
            [justMadeButton setFrame:CGRectMake(self.view.frame.size.width/2-word.stringSize.width/2,self.view.frame.size.height/2-(phoneme.stringSize.height/2)-65,phoneme.stringSize.width, phoneme.stringSize.height)];
        } else {
            //each consecutive button after the first button is placed just after it
            [justMadeButton setFrame:CGRectMake(lastButton.center.x+lastButton.frame.size.width/2,self.view.frame.size.height/2-(phoneme.stringSize.height/2)-65,phoneme.stringSize.width, phoneme.stringSize.height)];
        }
        [justMadeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray addObject:justMadeButton];
        [self.view addSubview:justMadeButton];
        lastButton = justMadeButton;
    }
}

- (void)buttonClicked:(UIButton *)sender {
    
    Sound * theSound = [[[SoundLibrary sharedLibrary] soundLibrary] objectForKey:sender.tagString];
    NSError * error = nil;
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:theSound.soundURL error:&error];
    self.soundPlayer.volume=1.0f;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops=0; //or more if needed
    /////////////////IF FINISHED
    if (self.phonemesCounter>self.phonemesToMatch) {
        [self.soundPlayer play];
        NSAttributedString * oldTitle = sender.currentAttributedTitle;
        NSAttributedString * whiteString = [[NSAttributedString alloc] initWithString:sender.titleLabel.text attributes:@{
                                                                                                                    NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],NSForegroundColorAttributeName:[UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f]}];
        
        [UIView transitionWithView:sender duration:0.4f options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            [sender setAttributedTitle:whiteString forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            [UIView transitionWithView:sender duration:0.4f options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                [sender setAttributedTitle:oldTitle forState:UIControlStateNormal];
            } completion:nil];
        }];
    }
}

- (void)colorBlockTouched:(DragColorView *)dragColorView{
    Sound * theSound = [[[SoundLibrary sharedLibrary] soundLibrary] objectForKey:dragColorView.identifier];
    NSError * error = nil;
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:theSound.soundURL error:&error];
    self.soundPlayer.volume=1.0f;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops=0; //or more if needed
    [self.soundPlayer play];
}

-(void)makeColorBlockOptions {
    NSMutableArray *sourceArray = [[[[SoundLibrary sharedLibrary] soundLibrary] allValues] mutableCopy];
    NSMutableArray *shufflingArray = [[NSMutableArray alloc] init];
    for(Phoneme *currentPhoneme in self.currentWord.phonemeArray){
        Sound *currentSound = [[[SoundLibrary sharedLibrary] soundLibrary] objectForKey:currentPhoneme.soundIdentifier];
        [sourceArray removeObject:currentSound];
        [shufflingArray addObject:currentSound];
    }
    int numberOfObjectsToAdd = 2;
    self.NumberOfChoices = (u_int32_t)(numberOfObjectsToAdd + shufflingArray.count);
    for(int i=0;i<numberOfObjectsToAdd;i++){
        int targetValue = arc4random_uniform((u_int32_t)sourceArray.count);
        [shufflingArray addObject:sourceArray[targetValue]];
        [sourceArray removeObjectAtIndex:targetValue];
    }
    NSUInteger count = [shufflingArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);
        [shufflingArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    self.colorBlockOptions = shufflingArray;
    //        [self.colorBlocksArray reloadData];
    
    
    ////////make a view for the color views to be in
//    self.wordView = [[UIView alloc] init];
//    self.wordView.userInteractionEnabled = NO;
//    self.wordView.backgroundColor = [UIColor blackColor];
//    [self.wordView setFrame:CGRectMake(self.view.frame.size.width/2-self.matchingWordToPlay.stringSize.width/2, self.view.frame.size.height/2-(self.matchingWordToPlay.stringSize.height/2)-300, self.matchingWordToPlay.stringSize.width, self.matchingWordToPlay.stringSize.height)];
//    [self.view addSubview:self.wordView];
    
    
    
    ///////////////////
    
    self.colorBlocksArray = [NSMutableArray new];
    //create color views
    for (int i=0;i<self.colorBlockOptions.count;i++) {
        Sound *sound = self.colorBlockOptions[i];
        DragColorView *lastColorView;
        DragColorView *dragColorView = [[DragColorView alloc] init];
        dragColorView.layer.masksToBounds = YES;
        dragColorView.layer.cornerRadius = 10;
        dragColorView.isSnapEnabled = NO;
        dragColorView.identifier = sound.identifier;
        if(sound.hasSecondaryColor){
            dragColorView.firstColor = sound.soundColor;
            dragColorView.secondColor = sound.secondaryColor;
        } else {
            dragColorView.firstColor = sound.soundColor;
            dragColorView.secondColor = nil;
        }
        [dragColorView setNeedsDisplay];
        int numberOfOptions = (u_int32_t)self.colorBlockOptions.count;
        int numberOptionsLessThanTen = 10-numberOfOptions;
        
        //if it is the first color block to be added
        if (self.colorBlocksArray.count==0) {
            //if number of options is <10 we have to recalculate the starting position
            if (numberOfOptions < 10) {
                self.startingXPosition = self.view.frame.origin.x+45+(numberOptionsLessThanTen*((kBlockMargin+kBlockWidth)/2));
                [dragColorView setFrame:CGRectMake(self.startingXPosition,self.view.frame.size.height/2+100, kBlockWidth, kBlockHeight)];
                dragColorView.originalPoint = dragColorView.center;
                
            } else {
                self.startingXPosition = self.view.frame.origin.x+45;
                [dragColorView setFrame:CGRectMake(self.startingXPosition,self.view.frame.size.height/2+100, kBlockWidth, kBlockHeight)];
                    dragColorView.originalPoint = dragColorView.center;
            }
            
        } else {
            [dragColorView setFrame:CGRectMake((self.startingXPosition + ((i)*(kBlockWidth+kBlockMargin))),self.view.frame.size.height/2+100, kBlockWidth, kBlockHeight)];
            dragColorView.originalPoint = dragColorView.center;
            
        }
        [self.view addSubview:dragColorView];
        dragColorView.dragDelegate = self;
        [self.colorBlocksArray addObject:dragColorView];
        lastColorView = dragColorView;
    }

}
-(void)dragColorView:(DragColorView *)dragColorView didDragToPoint:(CGPoint)pt {
    UIButton* targetButton = nil;
    for (UIButton *tb in self.buttonsArray) {
        if (CGRectContainsPoint(tb.frame, pt)) {
            targetButton = tb;
            break;
        }
    }
    //check if target was found
    if (targetButton) {
        //check if sound matches
        if ([targetButton.tagString isEqualToString:dragColorView.identifier]) {
            NSLog(@"Success!!");
            self.phonemesCounter += 1;
            //dragColorView removeFromSuperView and change letter to its color
            Sound *sound = [[[SoundLibrary sharedLibrary] soundLibrary] objectForKey:dragColorView.identifier];
            [self playSoundIfMatch:sound];
            
            [self lightUpPhonemeInWordForSound:sound andButton:targetButton];
            dragColorView.isMatched = YES;
            [dragColorView removeFromSuperview];
            
            NSLog(@"Check if the player has completed the phrase");
            
            //if all the colors in the word have been matched, display next word button
            if (self.phonemesCounter>self.phonemesToMatch) {
                [self.winPlayer stop];
                [self playWordButtonSound];
                [self displayNextWordButton];
            }
            
        } else {
            NSLog(@"Failure - no match.");
            [self.losePlayer play];
        }
    }
}

-(void)playSoundIfMatch:(Sound*)sound {
    NSError * error = nil;
//    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:sound.soundURL error:&error];
//    self.soundPlayer.volume=1.0f;
//    [self.soundPlayer prepareToPlay];
//    self.soundPlayer.numberOfLoops=0; //or more if needed
//    [self.soundPlayer play];
    NSURL *url3 = [[NSBundle mainBundle] URLForResource:@"Win" withExtension:@"wav"];
    self.winPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url3 error:&error];
    self.winPlayer.numberOfLoops = 0;
    [self.winPlayer prepareToPlay];
    self.winPlayer.volume = 1.0f;
    [self.winPlayer play];
}

-(void)displayNextWordButton {
    UIButton *button = [[UIButton alloc] init];
    UIButton *lastButton = [self.buttonsArray objectAtIndex:self.buttonsArray.count-1];
    [button setFrame:CGRectMake(lastButton.center.x+lastButton.frame.size.width,self.view.frame.size.height/2-(lastButton.frame.size.height/2)-20,40,75)];
    button.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *buttonImage = [UIImage imageNamed:@"next1"];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    self.nextWordButton = button;
    self.nextWordButton.alpha = 0;
    [self.view addSubview:self.nextWordButton];
    [self.view bringSubviewToFront:self.nextWordButton];
    self.nextWordButton.hidden = NO;
    [UIView transitionWithView:nil duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.nextWordButton.alpha = 1;
    }completion:^(BOOL finished) {
        [self.nextWordButton setNeedsDisplay];
        [self.nextWordButton addTarget:self action:@selector(nextWordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

-(void)nextWordButtonClicked:(UIButton*)nextWordButton {
    [self setUpAndGetReadyToPlay];
}

- (void)addDynamicBehaviour:(DragColorView *)dragColorView {
    [self.animator removeAllBehaviors];
    dragColorView.isSnapEnabled = YES;
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:dragColorView snapToPoint:dragColorView.originalPoint];
    [self.animator addBehavior:self.snapBehavior];

}

-(void)lightUpPhonemeInWordForSound:(Sound *)sound andButton:(UIButton*)button {
        NSAttributedString * attributedTitle;
        if(sound.hasSecondaryColor){
            attributedTitle = [[NSAttributedString alloc] initWithString:button.titleLabel.text attributes:@{
                                        NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],
                                        NSForegroundColorAttributeName:sound.soundColor,
                                        NSStrokeWidthAttributeName:[NSNumber numberWithFloat:StrokeWidth],
                                        NSStrokeColorAttributeName:sound.secondaryColor
                                        }];
        } else {
            attributedTitle = [[NSAttributedString alloc] initWithString:button.titleLabel.text attributes:@{
                                        NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],
                                        NSForegroundColorAttributeName:sound.soundColor}];
        }
        [button setTitle:nil forState:UIControlStateNormal];
        [button setAttributedTitle:attributedTitle forState:UIControlStateNormal];

}

-(void)setUpGameSounds {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Lose" withExtension:@"wav"];
    self.losePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.losePlayer.numberOfLoops = 0;
    [self.losePlayer prepareToPlay];
}

- (IBAction)goToMenu:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (IBAction)playWordSound:(id)sender {
    [self playWordButtonSound];
}

- (IBAction)playMovie:(id)sender {
    if (!self.moviePlayer) {
        self.moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gameone480" ofType:@"mov"]]];
    }
    [self presentViewController:self.moviePlayer animated:NO completion:^{
        [self.moviePlayer.moviePlayer play];
    }];
}

-(void) playWordButtonSound {
    NSError * error = nil;
    self.wordPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.currentWord.soundURL error:&error];
    self.wordPlayer.volume=1.0f;
    [self.wordPlayer prepareToPlay];
    self.wordPlayer.numberOfLoops=0; //or more if needed
    [self.wordPlayer play];
}
@end
