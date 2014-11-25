//
//  Phoneme.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "Sound.h"

@interface Phoneme : NSObject

@property (nonatomic, strong) NSString *letters;
@property (nonatomic, strong) NSString *soundIdentifier;
@property (nonatomic, strong) NSAttributedString *coloredString;
@property (nonatomic, assign) CGSize stringSize;

+ (instancetype)phonemeWithLetters:(NSString *)letters andSoundIdentifier:(NSString *)soundIdentifier;
- (instancetype)initWithLetters:(NSString *)letters andSoundIdentifier:(NSString *)soundIdentifier;

-(NSAttributedString *)buildAttributedString;
-(NSAttributedString *)buildEmptyAttributedString;

@end
