//
//  Game1ViewController.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-18.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorBlockView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Game1ViewController : UIViewController
@property (nonatomic) NSArray *soundsArray;
@property (weak, nonatomic) IBOutlet UIButton *playWordButton;
@property (weak, nonatomic) IBOutlet ColorBlockView *colorView;
@property (nonatomic) UIView *wordView;
@property (assign) int currentWordIndex;
@property (nonatomic, assign) BOOL shouldGoToSpecificSound;
@property (nonatomic, assign) NSString * soundIdentifier;
@property (strong, nonatomic) MPMoviePlayerViewController *moviePlayer;

@property (nonatomic) AVAudioPlayer *wordPlayer;
@property (nonatomic) AVAudioPlayer *soundPlayer;

- (IBAction)playNext:(id)sender;
- (IBAction)goToMenu:(id)sender;
- (IBAction)clickedColor:(id)sender;
- (IBAction)playBack:(id)sender;
- (IBAction)playWord:(id)sender;
- (IBAction)playMovie:(id)sender;

@end
