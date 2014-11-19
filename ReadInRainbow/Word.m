//
//  Word.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "Word.h"
#import "Phoneme.h"
#import "Sound.h"
#import "SoundLibrary.h"

@implementation Word

-(instancetype)initWithPhonemeArray:(NSArray *)phonemeArray {
    self = [super init];
    if(self) {
        self.phonemeArray = phonemeArray;
        int numberLetters;
        NSString *makeWordString;
        for (Phoneme *phoneme in self.phonemeArray) {
            numberLetters += phoneme.letters.length;
            if (makeWordString==nil) {
                makeWordString = [NSString stringWithString:phoneme.letters];
            } else {
                makeWordString = [makeWordString stringByAppendingString:phoneme.letters];
            }
        }
        self.numberOfLetters = numberLetters;
        self.wordString = makeWordString;
        self.stringSize = [self.wordString sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:120]}];
        
    }
    return self;
}

//-(NSAttributedString *)buildAttributedStringFromPhonemeArray {
//    NSMutableAttributedString * returnString = [[NSMutableAttributedString alloc] init];
//    SoundLibrary * newLibrary = [[SoundLibrary alloc]init];
//    for(Phoneme * currentPhoneme in self.phonemeArray) {
//        Sound * currentSound = newLibrary.soundLibrary[currentPhoneme.soundIdentifier];
//        
//    }
//}

@end
