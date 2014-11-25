//
//  Game3ViewController.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface Game3ViewController : UIViewController

@property (nonatomic, strong) NSArray *soundsArray;
@property (nonatomic) AVAudioPlayer *soundPlayer;
- (IBAction)goToMenu:(id)sender;

@end
