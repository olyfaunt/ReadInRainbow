//
//  Game2ViewController.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface Game2ViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *livesImageViewToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorBlock2ToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorBlock3ToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorBlock1ToBottom;

@property (nonatomic, strong) NSArray * soundsArray;
@property (weak, nonatomic) IBOutlet UIImageView *livesImageView;
- (IBAction)gameOver:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *gameOverButton;
//@property (nonatomic) AVAudioPlayer *wordPlayer;
@property (nonatomic) AVAudioPlayer *soundPlayer;
@property (nonatomic) AVAudioPlayer *winPlayer;
@property (nonatomic) AVAudioPlayer *losePlayer;
@property (nonatomic) AVAudioPlayer *gameOverPlayer;

@end
