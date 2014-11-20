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

@interface Game1ViewController ()

@property (nonatomic) Sound *currentSound;
@property (nonatomic) int currentIndex;

@end

@implementation Game1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentIndex = 0;
    self.currentSound = self.soundsArray[self.currentIndex];
    [self changedColor];
    
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
    } else {
        self.currentIndex = 0;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
    }
}

- (IBAction)playBack:(id)sender {
    if (self.currentIndex > 0) {
        self.currentIndex -= 1;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
    } else {
        self.currentIndex = (int)self.soundsArray.count-1;
        self.currentSound = self.soundsArray[self.currentIndex];
        [self changedColor];
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
@end
