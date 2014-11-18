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
