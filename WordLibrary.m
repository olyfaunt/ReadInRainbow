//
//  WordLibrary.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "WordLibrary.h"
#import "Sound.h"
#import "Phoneme.h"
#import "Word.h"

@implementation WordLibrary

+ (id)sharedLibrary {
    static WordLibrary *sharedLibrary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLibrary = [[self alloc] init];
    });
    return sharedLibrary;
}

-(instancetype)init {
    self = [super init];
    if(self) {
        self.wordLibrary = @{
                              @"demo":[Word WordWithWordFileNamed:@"demo" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"d" andSoundIdentifier:@"d"], [Phoneme phonemeWithLetters:@"e" andSoundIdentifier:@"eh"], [Phoneme phonemeWithLetters:@"m" andSoundIdentifier:@"m"], [Phoneme phonemeWithLetters:@"o" andSoundIdentifier:@"longo"]]],
                              @"day":[Word WordWithWordFileNamed:@"day" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"d" andSoundIdentifier:@"d"], [Phoneme phonemeWithLetters:@"ay" andSoundIdentifier:@"longa"]]],
                              @"lighthouse":[Word WordWithWordFileNamed:@"lighthouse" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"l" andSoundIdentifier:@"el"], [Phoneme phonemeWithLetters:@"igh" andSoundIdentifier:@"longi"], [Phoneme phonemeWithLetters:@"t" andSoundIdentifier:@"t"], [Phoneme phonemeWithLetters:@"h" andSoundIdentifier:@"h"], [Phoneme phonemeWithLetters:@"ou" andSoundIdentifier:@"au"], [Phoneme phonemeWithLetters:@"se" andSoundIdentifier:@"s"]]],
                              @"labs":[Word WordWithWordFileNamed:@"labs" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"l" andSoundIdentifier:@"el"], [Phoneme phonemeWithLetters:@"a" andSoundIdentifier:@"ah"], [Phoneme phonemeWithLetters:@"b" andSoundIdentifier:@"b"], [Phoneme phonemeWithLetters:@"s" andSoundIdentifier:@"s"]]],
                              @"egg":[Word WordWithWordFileNamed:@"egg" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"e" andSoundIdentifier:@"eh"], [Phoneme phonemeWithLetters:@"gg" andSoundIdentifier:@"g"]]],
                              @"book":[Word WordWithWordFileNamed:@"book" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"b" andSoundIdentifier:@"b"], [Phoneme phonemeWithLetters:@"oo" andSoundIdentifier:@"euh"], [Phoneme phonemeWithLetters:@"k" andSoundIdentifier:@"k"]]],
                              @"north":[Word WordWithWordFileNamed:@"north" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"n" andSoundIdentifier:@"n"], [Phoneme phonemeWithLetters:@"or" andSoundIdentifier:@"or"], [Phoneme phonemeWithLetters:@"th" andSoundIdentifier:@"th"]]],
                              @"shoe":[Word WordWithWordFileNamed:@"shoe" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"sh" andSoundIdentifier:@"sh"], [Phoneme phonemeWithLetters:@"oe" andSoundIdentifier:@"oo"]]],
                              @"father":[Word WordWithWordFileNamed:@"father" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"f" andSoundIdentifier:@"f"], [Phoneme phonemeWithLetters:@"a" andSoundIdentifier:@"ahh"], [Phoneme phonemeWithLetters:@"th" andSoundIdentifier:@"thth"], [Phoneme phonemeWithLetters:@"er" andSoundIdentifier:@"schwar"]]],
                              @"team":[Word WordWithWordFileNamed:@"team" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"t" andSoundIdentifier:@"t"], [Phoneme phonemeWithLetters:@"ea" andSoundIdentifier:@"longe"], [Phoneme phonemeWithLetters:@"m" andSoundIdentifier:@"m"]]],
                              @"zipper":[Word WordWithWordFileNamed:@"zipper" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"z" andSoundIdentifier:@"z"], [Phoneme phonemeWithLetters:@"i" andSoundIdentifier:@"ih"], [Phoneme phonemeWithLetters:@"pp" andSoundIdentifier:@"p"], [Phoneme phonemeWithLetters:@"er" andSoundIdentifier:@"schwar"]]],
                              @"choice":[Word WordWithWordFileNamed:@"choice" andPhonemeArray:@[[Phoneme phonemeWithLetters:@"ch" andSoundIdentifier:@"ch"], [Phoneme phonemeWithLetters:@"oi" andSoundIdentifier:@"oy"], [Phoneme phonemeWithLetters:@"ce" andSoundIdentifier:@"s"]]],
                              };
    }
    return self;
}


@end
