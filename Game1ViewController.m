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
    [self changedColor];
    [self getArrayOfMatchingWords];
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
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
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
}

- (IBAction)playBack:(id)sender {
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
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
}

- (IBAction)playWord:(id)sender {
    [self.matchingWordToPlay playSound];
}

- (IBAction)goToMenu:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (IBAction)clickedColor:(id)sender {
    [self.currentSound playSound];
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
    int randomNumber = arc4random_uniform((u_int32_t)[self.matchingWordsArray count]);
    self.matchingWordToPlay = [self.matchingWordsArray objectAtIndex:randomNumber];
    NSLog(@"Current Sound: %@, Matching Word: %@ out of Array: %@", self.currentSound.identifier, self.matchingWordToPlay.identifier, self.matchingWordsArray);
    [self createButtonForWord:self.matchingWordToPlay];
}

/////////////////SPACING///////////////////////////////////////////////////
////if SPACING between the words is needed, in ELSE, just add +Spacing after lastButton.frame.size.width/2, and in IF, change word.stringSize to word.spacedStringSize
-(void) createButtonForWord:(Word*)word {
    UIButton *lastButton;
    for (Phoneme *phoneme in word.phonemeArray) {
        UIButton *justMadeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justMadeButton setTagString:phoneme.soundIdentifier];
        [justMadeButton setAttributedTitle:[phoneme buildAttributedString] forState:UIControlStateNormal];
        if (lastButton ==nil) {
            //first button/phoneme of the word is placed at X half of the word's width leftwards from half of the screen's width (so the word is centered) - its Y is at half of the frame's height minus half of the phoneme's stringSize height
            [justMadeButton setFrame:CGRectMake(self.view.frame.size.width/2-word.stringSize.width/2,self.view.frame.size.height/2-(phoneme.stringSize.height/2)-300,phoneme.stringSize.width, phoneme.stringSize.height)];
        } else {
            //each consecutive button after the first button is placed just after it
            [justMadeButton setFrame:CGRectMake(lastButton.center.x+lastButton.frame.size.width/2,self.view.frame.size.height/2-(phoneme.stringSize.height/2)-300,phoneme.stringSize.width, phoneme.stringSize.height)];
        }
        [justMadeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray addObject:justMadeButton];
        [self.view addSubview:justMadeButton];
        lastButton = justMadeButton;
    }
}

-(void) buttonClicked:(UIButton*)sender {
    NSString *idString = sender.tagString;
    Sound *soundOfButton = [[SoundLibrary sharedLibrary] soundLibrary][idString];
    [soundOfButton playSound];
}
@end
