//
//  WordViewController.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "WordViewController.h"
#import "SoundLibrary.h"
#import "Sound.h"
#import "Phoneme.h"
#import "Word.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ColorBlockView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+setTag.h"
#import "WordLibrary.h"
#import "Util.h"

@interface WordViewController ()

@property (nonatomic) Word *currentWord;
@property (nonatomic) int currentIndex;
@property (nonatomic) NSMutableArray *buttonsArray;

@end

@implementation WordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.buttonsArray = [NSMutableArray new];
    self.currentIndex = 0;
    self.wordsArray = [[[WordLibrary sharedLibrary] wordLibrary] allValues];
    self.currentWord = self.wordsArray[self.currentIndex];
    [self createButtonForWord:self.currentWord];
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
            [justMadeButton setFrame:CGRectMake(self.view.frame.size.width/2-word.stringSize.width/2,self.view.frame.size.height/2-(phoneme.stringSize.height/2),phoneme.stringSize.width, phoneme.stringSize.height)];
        } else {
            //each consecutive button after the first button is placed just after it
            [justMadeButton setFrame:CGRectMake(lastButton.center.x+lastButton.frame.size.width/2,self.view.frame.size.height/2-(phoneme.stringSize.height/2),phoneme.stringSize.width, phoneme.stringSize.height)];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goToMenu:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (IBAction)backWord:(id)sender {
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
    if (self.currentIndex > 0) {
        self.currentIndex -= 1;
        self.currentWord = self.wordsArray[self.currentIndex];
        [self createButtonForWord:self.currentWord];
    } else {
        self.currentIndex = (int)self.wordsArray.count-1;
        self.currentWord = self.wordsArray[self.currentIndex];
        [self createButtonForWord:self.currentWord];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextWord:(id)sender {
    for (UIButton *button in self.buttonsArray) {
        [button removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
    if (self.currentIndex < self.wordsArray.count-1) {
        self.currentIndex += 1;
        self.currentWord = self.wordsArray[self.currentIndex];
        [self createButtonForWord:self.currentWord];
    } else {
        self.currentIndex = 0;
        self.currentWord = self.wordsArray[self.currentIndex];
        [self createButtonForWord:self.currentWord];
    }
}

- (IBAction)playWord:(id)sender {
    [self.currentWord playSound];
}

- (IBAction)changeTest:(id)sender {
    for (UIButton *button in self.buttonsArray) {
        NSString *myString = button.currentAttributedTitle.string;
        button.enabled = NO;
        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:myString attributes:@{
                NSFontAttributeName:[UIFont boldSystemFontOfSize:FontSize],
                NSForegroundColorAttributeName:[UIColor whiteColor],
                NSStrokeWidthAttributeName:[NSNumber numberWithFloat:-6.0],
                NSStrokeColorAttributeName:[UIColor grayColor]}] forState:UIControlStateDisabled];
    }
}
@end
