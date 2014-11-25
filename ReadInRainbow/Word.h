//
//  Word.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface Word : NSObject

@property (nonatomic, strong) NSArray *phonemeArray;
@property (nonatomic) NSString *wordString;
@property (nonatomic, assign) int numberOfLetters;
@property (nonatomic, assign) CGSize stringSize;
@property (nonatomic, assign) CGSize spacedStringSize;

//@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSURL *soundURL;
@property (nonatomic) BOOL isSpaced;

+(instancetype)WordWithWordFileNamed:(NSString*)fileName andPhonemeArray:(NSArray*)phonemeArray;
-(instancetype)initWithWordFileNamed:(NSString*)fileName andPhonemeArray:(NSArray*)phonemeArray;
-(void)playSound;
//- (instancetype)initWithPhonemeArray:(NSArray *)phonemeArray;
@end
