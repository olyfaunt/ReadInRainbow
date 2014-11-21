//
//  Phoneme.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "Phoneme.h"
#import "SoundLibrary.h"
#import "Util.h"

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
        self.stringSize = [self.letters sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize]}];
    }
    return self;
}

-(NSAttributedString *)buildAttributedString {
    Sound * currentSound = [[SoundLibrary sharedLibrary] soundLibrary][self.soundIdentifier];
    NSAttributedString * returnString;
    if(currentSound.hasSecondaryColor){
        /////// boldSystemFontOfSize:FontSize]
        returnString = [[NSAttributedString alloc] initWithString:self.letters attributes:@{
                        NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],
                        NSForegroundColorAttributeName:currentSound.soundColor,
                        NSStrokeWidthAttributeName:[NSNumber numberWithFloat:StrokeWidth],
                        NSStrokeColorAttributeName:currentSound.secondaryColor
                        }];
    } else {
        returnString = [[NSAttributedString alloc] initWithString:self.letters attributes:@{
                        NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],NSForegroundColorAttributeName:currentSound.soundColor}];
    }
    return returnString;
}

-(NSAttributedString *)buildEmptyAttributedString {
    NSAttributedString * returnString =
    [[NSAttributedString alloc] initWithString:self.letters attributes:@{
                        NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],
                        NSForegroundColorAttributeName:[UIColor whiteColor],
                        NSStrokeWidthAttributeName:[NSNumber numberWithFloat:StrokeWidth],
                        NSStrokeColorAttributeName:[UIColor grayColor]}];
    return returnString;
}

@end
