//
//  Phoneme.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sound.h"

@interface Phoneme : NSObject

@property (nonatomic, strong) NSString * letters;
@property (nonatomic, strong) NSString * soundIdentifier;

+ (instancetype)phonemeWithLetters:(NSString *)letters andSoundIdentifier:(NSString *)soundIdentifier;
- (instancetype)initWithLetters:(NSString *)letters andSoundIdentifier:(NSString *)soundIdentifier;

@end
