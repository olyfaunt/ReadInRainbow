//
//  Sound.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Sound : NSObject

@property (nonatomic, strong) UIColor * soundColor;
@property (nonatomic, strong) UIColor * secondaryColor;
@property (nonatomic, assign) BOOL hasSecondaryColor;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) AVAudioPlayer * audioPlayer;

-(id)initWithPhoneme;

+(instancetype)SoundWithSoundFileNamed:(NSString *)fileName andFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor;
-(instancetype)initWithSoundFileNamed:(NSString *)fileName andFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor;
-(void)playSound;

@end
