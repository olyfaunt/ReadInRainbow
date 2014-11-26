//
//  Game1ViewController.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-18.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "Game1ViewController.h"
#import "SoundLibrary.h"
#import "Sound.h"
#import "Phoneme.h"
#import "Word.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ColorBlockView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "WordLibrary.h"
#import "UIButton+setTag.h"
#import "UIView+Shake.h"

@interface Game1ViewController ()

@property (nonatomic) Sound *currentSound;
@property (nonatomic) int currentIndex;
@property (nonatomic) NSMutableArray *matchingWordsArray;
@property (nonatomic) Word *currentWord;
@property (nonatomic) Word *matchingWordToPlay;
@property (nonatomic) NSDictionary *wordDictionary;
@property (nonatomic) NSMutableArray *buttonsArray;

@end

@implementation Game1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buttonsArray = [NSMutableArray new];
    self.matchingWordsArray = [NSMutableArray new];
    self.wordDictionary = [[WordLibrary sharedLibrary] wordLibrary];
    self.currentIndex = 0;
    self.currentSound = self.soundsArray[self.currentIndex];
    self.playWordButton.hidden = YES;
    [self changedColor];
    [self getArrayOfMatchingWords];
    
    UISwipeGestureRecognizer *swipePageLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipePageLeft)];
    [swipePageLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    UISwipeGestureRecognizer *swipePageRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipePageRight)];
    [swipePageRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipePageLeft];
    [self.view addGestureRecognizer:swipePageRight];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playNext:(id)sender {
    [self.wordView removeFromSuperview];
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
    self.playWordButton.hidden = YES;
    if (self.currentIndex < self.soundsArray.count-1) {
        self.currentIndex += 1;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
        [self getArrayOfMatchingWords];
    } else {
        self.currentIndex = 0;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
        [self getArrayOfMatchingWords];
    }
    
    [UIView transitionWithView:self.view
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:nil completion:nil];
}

- (IBAction)playBack:(id)sender {
    [self.wordView removeFromSuperview];
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
    self.playWordButton.hidden = YES;
    if (self.currentIndex > 0) {
        self.currentIndex -= 1;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
        [self getArrayOfMatchingWords];
    } else {
        self.currentIndex = (int)self.soundsArray.count-1;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
        [self getArrayOfMatchingWords];
    }
    [UIView transitionWithView:self.view
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:nil completion:nil];
}

- (IBAction)playWord:(id)sender {
    NSError *error;
    self.wordPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.matchingWordToPlay.soundURL error:&error];
    self.wordPlayer.volume=1.0f;
    [self.wordPlayer prepareToPlay];
    self.wordPlayer.numberOfLoops=0; //or more if needed
    [self.wordPlayer play];
}

- (IBAction)goToMenu:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (IBAction)clickedColor:(id)sender {
    NSError *error;
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.currentSound.soundURL error:&error];
    self.soundPlayer.volume=1.0f;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops=0; //or more if needed
    [self.soundPlayer play];

    self.playWordButton.alpha = 0;
    self.playWordButton.hidden = NO;
    [UIView transitionWithView:self.playWordButton duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.playWordButton.alpha = 1;
                    }completion:nil];
    
    [self createButtonForWord:self.matchingWordToPlay];
    
}

-(void)changedColor {
    if (!self.currentSound.hasSecondaryColor) {
        [self.colorView setFirstColor:self.currentSound.soundColor];
        self.colorView.secondColor = nil;
    } else {
        [self.colorView setFirstColor:self.currentSound.soundColor];
        self.colorView.secondColor = self.currentSound.secondaryColor;
    }
    [self.colorView setNeedsDisplay];
}

-(void)getArrayOfMatchingWords {
    [self.matchingWordsArray removeAllObjects];
    for(id key in self.wordDictionary) {
        self.currentWord = [self.wordDictionary objectForKey:key];
        for (Phoneme *phoneme in self.currentWord.phonemeArray) {
            if ([phoneme.soundIdentifier isEqualToString:self.currentSound.identifier]) {
                [self.matchingWordsArray addObject:self.currentWord];
            }
        }
    }
//    int randomNumber = arc4random_uniform((u_int32_t)[self.matchingWordsArray count]);
    self.currentWordIndex = 0;
    self.matchingWordToPlay = [self.matchingWordsArray objectAtIndex:self.currentWordIndex];
    NSLog(@"Current Sound: %@, Matching Word: %@ out of Array: %@", self.currentSound.identifier, self.matchingWordToPlay.identifier, self.matchingWordsArray);
//    [self createButtonForWord:self.matchingWordToPlay]; MOVED FROM HERE TO CLICKED COLOR
}

/////////////////SPACING///////////////////////////////////////////////////
////if SPACING between the words is needed, in ELSE, just add +Spacing after lastButton.frame.size.width/2, and in IF, change word.stringSize to word.spacedStringSize
-(void) createButtonForWord:(Word*)word {
    self.wordView = [[UIView alloc] init];
    self.wordView.userInteractionEnabled = YES;
    self.wordView.backgroundColor = [UIColor clearColor];
    [self.wordView setFrame:CGRectMake(self.view.frame.size.width/2-self.matchingWordToPlay.stringSize.width/2, self.view.frame.size.height/2-(self.matchingWordToPlay.stringSize.height/2)-300, self.matchingWordToPlay.stringSize.width, self.matchingWordToPlay.stringSize.height)];
    [self.view addSubview:self.wordView];
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftMethod)];
    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightMethod)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.wordView addGestureRecognizer:swipeGestureLeft];
    [self.wordView addGestureRecognizer:swipeGestureRight];
    //add buttons as subview to wordView so swipe will get delegated down
    
    UIButton *lastButton;
    for (Phoneme *phoneme in word.phonemeArray) {
        UIButton *justMadeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justMadeButton setTagString:phoneme.soundIdentifier];
        [justMadeButton setAttributedTitle:[phoneme buildAttributedString] forState:UIControlStateNormal];
        if (lastButton ==nil) {
            //first button/phoneme of the word is placed at X half of the word's width leftwards from half of the screen's width (so the word is centered) - its Y is at half of the frame's height minus half of the phoneme's stringSize height
            [justMadeButton setFrame:CGRectMake(0,0,phoneme.stringSize.width, phoneme.stringSize.height)];
        } else {
            //each consecutive button after the first button is placed just after it
            [justMadeButton setFrame:CGRectMake(lastButton.center.x+lastButton.frame.size.width/2,0,phoneme.stringSize.width, phoneme.stringSize.height)];
        }
        [justMadeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray addObject:justMadeButton];
        [self.wordView addSubview:justMadeButton];
        
        if (self.currentWordIndex==0 && self.currentIndex==0) {
            [justMadeButton shakeButton:justMadeButton];
            NSUInteger x = self.buttonsArray.count;
            if (!(x%2==0)) {
                [justMadeButton shakeOneButton:justMadeButton];
            }
        }
        justMadeButton.alpha = 0;
        [UIView transitionWithView:justMadeButton
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:^{
                            justMadeButton.alpha = 1;
                        } completion:^(BOOL finished) {
                            if (self.matchingWordsArray.count > 1) {
                                [NSTimer scheduledTimerWithTimeInterval:3.0
                                                                 target:self
                                                               selector:@selector(shakeView)
                                                               userInfo:nil
                                                                repeats:NO];
                            }
                        }];
        
        lastButton = justMadeButton;
    }
}

-(void)shakeView {
    [self.wordView shakeView:self.wordView];
}

-(void) buttonClicked:(UIButton*)sender {
    NSString *idString = sender.tagString;
    Sound *soundOfButton = [[SoundLibrary sharedLibrary] soundLibrary][idString];
    NSError *error;
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundOfButton.soundURL error:&error];
    self.soundPlayer.volume=1.0f;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops=0; //or more if needed
    [self.soundPlayer play];
//    [soundOfButton playSound];
}

#pragma mark - Gesture Recognizer Methods

-(void) swipeLeftMethod {
    if (self.currentWordIndex < (int)self.matchingWordsArray.count-1) {
        for (UIButton *button in self.buttonsArray) {
            [button removeFromSuperview];
        }
        [self.buttonsArray removeAllObjects];
        [self.wordView removeFromSuperview];
        
        self.currentWordIndex++;
        self.matchingWordToPlay = [self.matchingWordsArray objectAtIndex:self.currentWordIndex];
        [self createButtonForWord:self.matchingWordToPlay];
    } else {
        for (UIButton *button in self.buttonsArray) {
            [button removeFromSuperview];
        }
        [self.buttonsArray removeAllObjects];
        [self.wordView removeFromSuperview];
        self.currentWordIndex = 0;
        self.matchingWordToPlay = [self.matchingWordsArray objectAtIndex:self.currentWordIndex];
        [self createButtonForWord:self.matchingWordToPlay];
    }
}

-(void) swipeRightMethod {
    if (self.currentWordIndex > 0) {
        for (UIButton *button in self.buttonsArray) {
            [button removeFromSuperview];
        }
        [self.buttonsArray removeAllObjects];
        [self.wordView removeFromSuperview];
        
        self.currentWordIndex--;
        self.matchingWordToPlay = [self.matchingWordsArray objectAtIndex:self.currentWordIndex];
        [self createButtonForWord:self.matchingWordToPlay];
    } else {
        for (UIButton *button in self.buttonsArray) {
            [button removeFromSuperview];
        }
        [self.buttonsArray removeAllObjects];
        [self.wordView removeFromSuperview];
        self.currentWordIndex = (int)self.matchingWordsArray.count-1;
        self.matchingWordToPlay = [self.matchingWordsArray objectAtIndex:self.currentWordIndex];
        [self createButtonForWord:self.matchingWordToPlay];
    }
}

-(void) swipePageLeft {
    
    [self.wordView removeFromSuperview];
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
    self.playWordButton.hidden = YES;
    if (self.currentIndex < self.soundsArray.count-1) {
        self.currentIndex += 1;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
        [self getArrayOfMatchingWords];
    } else {
        self.currentIndex = 0;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
        [self getArrayOfMatchingWords];
    }
    
    [UIView transitionWithView:self.view
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:nil completion:nil];
    
}

-(void) swipePageRight {
    [self.wordView removeFromSuperview];
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
    self.playWordButton.hidden = YES;
    if (self.currentIndex > 0) {
        self.currentIndex -= 1;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
        [self getArrayOfMatchingWords];
    } else {
        self.currentIndex = (int)self.soundsArray.count-1;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
        [self getArrayOfMatchingWords];
    }
    [UIView transitionWithView:self.view
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:nil completion:nil];
}

@end
