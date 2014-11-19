//
//  Phoneme.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "Phoneme.h"
#import "SoundLibrary.h"

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
        self.coloredString = [self buildAttributedString];
    }
    return self;
}

-(NSAttributedString *)buildAttributedString {
    Sound * currentSound = [[SoundLibrary sharedLibrary] soundLibrary][self.soundIdentifier];
    NSAttributedString * returnString;
    if(currentSound.hasSecondaryColor){
        returnString = [[NSAttributedString alloc] initWithString:self.letters attributes:@{
                        NSForegroundColorAttributeName:currentSound.soundColor,
                        NSStrokeWidthAttributeName:[NSNumber numberWithFloat:-3.0],
                        NSStrokeColorAttributeName:currentSound.secondaryColor
                        }];
    } else {
        returnString = [[NSAttributedString alloc] initWithString:self.letters attributes:@{NSForegroundColorAttributeName:currentSound.soundColor}];
    }
    return returnString;
}

@end
