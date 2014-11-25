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
#import "Util.h"

@implementation Word

+(instancetype)WordWithWordFileNamed:(NSString*)fileName andPhonemeArray:(NSArray*)phonemeArray {
    Word *newWord = [[self alloc] initWithWordFileNamed:fileName andPhonemeArray:phonemeArray];
    return newWord;
}
-(instancetype)initWithWordFileNamed:(NSString*)fileName andPhonemeArray:(NSArray*)phonemeArray {
    self = [super init];
    
    if(self) {
        self.soundURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"]];
//        NSError * error;
//        self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
//        self.audioPlayer.volume=1.0f;
        self.identifier = [fileName copy];
        // Needs logic to take the sound file and get the color for it, and also set a secondary color if there is one
        
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
        
        ///test
        self.stringSize = [self.wordString sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize]}];
        CGSize newSize = [self.wordString sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize]}];
        newSize.width += (Spacing*(self.phonemeArray.count-1));
        self.spacedStringSize = newSize;

    }
    return self;
}

//-(void)playSound {
//    [self.audioPlayer prepareToPlay];
//    self.audioPlayer.numberOfLoops=0; //or more if needed
//    [self.audioPlayer play];
//}

//-(instancetype)initWithPhonemeArray:(NSArray *)phonemeArray {
//    self = [super init];
//    if(self) {
//        self.phonemeArray = phonemeArray;
//        int numberLetters;
//        NSString *makeWordString;
//        for (Phoneme *phoneme in self.phonemeArray) {
//            numberLetters += phoneme.letters.length;
//            if (makeWordString==nil) {
//                makeWordString = [NSString stringWithString:phoneme.letters];
//            } else {
//                makeWordString = [makeWordString stringByAppendingString:phoneme.letters];
//            }
//        }
//        self.numberOfLetters = numberLetters;
//        self.wordString = makeWordString;
//        self.stringSize = [self.wordString sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:120]}];
//        
//    }
//    return self;
//}


@end
