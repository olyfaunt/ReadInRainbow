//
//  Phoneme.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "Phoneme.h"

@implementation Phoneme

+(instancetype)phonemeWithLetters:(NSString *)letters andSoundIdentifier:(NSString *)soundIdentifier {
    Phoneme * newPhoneme = [[self alloc] initWithLetters:letters andSoundIdentifier:soundIdentifier];
    return newPhoneme;
}

-(instancetype)initWithLetters:(NSString *)letters andSoundIdentifier:(NSString *)soundIdentifier {
    self = [super init];
    if(self) {
        self.soundIdentifier = soundIdentifier;
        self.letters = letters;
    }
    return self;
}

@end
