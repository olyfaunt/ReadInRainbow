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

@interface Game1ViewController ()

@property (nonatomic) Sound *currentSound;
@property (nonatomic) int currentIndex;
@property (nonatomic) NSMutableArray *matchingWordsArray;
@property (nonatomic) Word *currentWord;
@property (nonatomic) Word *matchingWordToPlay;
@property (nonatomic) NSDictionary *wordDictionary;

@end

@implementation Game1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
}

@end
