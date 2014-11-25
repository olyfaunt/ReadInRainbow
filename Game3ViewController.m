//
//  Game3ViewController.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "Game3ViewController.h"
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

@interface Game3ViewController ()

@end

@implementation Game3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *lastButton;
    Phoneme *day1 = [Phoneme phonemeWithLetters:@"d" andSoundIdentifier:@"d"];
    Phoneme *day2 = [Phoneme phonemeWithLetters:@"aylasdkjfsd" andSoundIdentifier:@"longa"];
    Phoneme *day3 = [Phoneme phonemeWithLetters:@"lal" andSoundIdentifier:@"er"];
    Word *day = [Word WordWithWordFileNamed:@"day" andPhonemeArray:@[day1, day2, day3]];
    for (Phoneme *phoneme in day.phonemeArray) {
        UIButton *justMadeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        justMadeButton.tagString = phoneme.soundIdentifier;
        [justMadeButton setAttributedTitle:[phoneme buildAttributedString] forState:UIControlStateNormal];
        if (lastButton ==nil) {
            [justMadeButton setFrame:CGRectMake(self.view.frame.size.width/2-day.stringSize.width/2,self.view.frame.size.height/2,phoneme.stringSize.width, phoneme.stringSize.height)];
        } else {
            [justMadeButton setFrame:CGRectMake(lastButton.center.x+lastButton.frame.size.width/2,self.view.frame.size.height/2,phoneme.stringSize.width, phoneme.stringSize.height)];
        }
        [justMadeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:justMadeButton];
        lastButton = justMadeButton;
    }
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goToMenu:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}
@end
