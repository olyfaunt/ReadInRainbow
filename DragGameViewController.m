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
    [self setUpAndGetReadyToPlay];
    // Do any additional setup after loading the view.
//    self.dragAndDropController = (DNDDragAndDropController*)self;
//    [self.dragAndDropController registerDragSource:self.colorPickerCollectionView withDelegate:self];
//    [self.dragAndDropController registerDropTarget:self.view withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpAndGetReadyToPlay {
    [self removeColorBlockOptions];
    [self generateAndDisplayWord];
    [self makeColorBlockOptions];
//    self.gameOverButton.hidden = YES;
    self.placeInPhonemeArray = 0;
    self.nextWordButton.hidden = YES;
}

-(void)removeColorBlockOptions {
    for (DragColorView *dragColorView in self.colorBlocksArray) {
        [dragColorView removeFromSuperview];
    }
    [self.colorBlocksArray removeAllObjects];
}

- (void)generateAndDisplayWord {
    NSArray * wordArray = [[[WordLibrary sharedLibrary] wordLibrary] allValues];
    self.currentWord = wordArray[arc4random_uniform((u_int32_t)wordArray.count)];
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
    [self.soundPlayer play];
}

-(void)makeColorBlockOptions {
///
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
//////
    
//    NSArray *tenArray = [self.soundsArray subarrayWithRange:NSMakeRange(0, 5)];
    
    self.colorBlocksArray = [NSMutableArray new];
    //create tiles
    for (int i=0;i<self.colorBlockOptions.count;i++) {
        Sound *sound = self.colorBlockOptions[i];
        DragColorView *lastColorView;
        DragColorView *dragColorView = [[DragColorView alloc] init];
        dragColorView.identifier = sound.identifier;
        if(sound.hasSecondaryColor){
            dragColorView.firstColor = sound.soundColor;
            dragColorView.secondColor = sound.secondaryColor;
        } else {
            dragColorView.firstColor = sound.soundColor;
            dragColorView.secondColor = nil;
        }
        [dragColorView setNeedsDisplay];
        int numberOfOptions = self.colorBlockOptions.count;
        int numberOptionsLessThanTen = 10-numberOfOptions;
        
        if (self.colorBlocksArray.count==0) {
            
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
            //dragColorView removeFromSuperView and change letter to its color
            Sound *sound = [[[SoundLibrary sharedLibrary] soundLibrary] objectForKey:dragColorView.identifier];
            [self lightUpPhonemeInWordForSound:sound andButton:targetButton];
            [dragColorView removeFromSuperview];
            
            NSLog(@"Check if the player has completed the phrase");
        } else {
            //4
            NSLog(@"Failure - no match.");
            //dragColorView snaps back to original position
            [self addDynamicBehaviour:dragColorView];
            //more stuff to do on failure here        
        }
    }
    NSLog(@"To implement");
}

- (void)addDynamicBehaviour:(DragColorView *)dragColorView {
    
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
                                                                                                                    NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],NSForegroundColorAttributeName:sound.soundColor}];
        }
        
        [button setTitle:nil forState:UIControlStateNormal];
        [button setAttributedTitle:attributedTitle forState:UIControlStateNormal];

}


//- (void)setUpCollectionView {
//    self.colorPickerCollectionView.delegate = self;
//    self.colorPickerCollectionView.dataSource = self;
//}
//
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.soundsArray.count;
//}
//
//
//-(DragCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    DragCell * newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    Sound *soundForCell = self.soundsArray[indexPath.row];
//    newCell.dragColorView.firstColor = soundForCell.soundColor;
//    if(soundForCell.hasSecondaryColor) {
//        newCell.dragColorView.secondColor = soundForCell.secondaryColor;
//    } else {
//        newCell.dragColorView.secondColor = nil;
//    }
//    [newCell.dragColorView setNeedsDisplay]; //
//    return newCell;
//}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    Sound * soundAtCell = self.collectionViewOptions[indexPath.item];
//    NSError * error = nil;
//    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundAtCell.soundURL error:&error];
//    self.soundPlayer.volume=1.0f;
//    [self.soundPlayer prepareToPlay];
//    self.soundPlayer.numberOfLoops=0; //or more if needed
//    [self.soundPlayer play];
//    if(self.placeInPhonemeArray >= self.currentWord.phonemeArray.count) {
//        // do nothing
//    } else if([[self.currentWord.phonemeArray[self.placeInPhonemeArray] soundIdentifier] isEqualToString:soundAtCell.identifier]){
//        [self lightUpPhonemeInWordForSound:soundAtCell];
//        self.placeInPhonemeArray++;
//        if(self.placeInPhonemeArray >= self.currentWord.phonemeArray.count){
//            [self displayNextWordButton];
//        }
//    } else {
//        [self loseOneLife];
//    }
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goToMenu:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (IBAction)playWordSound:(id)sender {
    NSError * error = nil;
    self.wordPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.currentWord.soundURL error:&error];
    self.wordPlayer.volume=1.0f;
    [self.wordPlayer prepareToPlay];
    self.wordPlayer.numberOfLoops=0; //or more if needed
    [self.wordPlayer play];
}
@end
