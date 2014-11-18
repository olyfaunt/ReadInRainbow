//
//  Sound.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "Sound.h"

@implementation Sound

+(instancetype)SoundWithSoundFileNamed:(NSString *)fileName andFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor {
    Sound * newSound = [[self alloc] initWithSoundFileNamed:fileName andFirstColor:firstColor andSecondColor:secondColor];
    return newSound;
}

-(instancetype)initWithSoundFileNamed:(NSString *)fileName {
    self = [super init];
    
    if(self) {
        NSURL * soundURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"]];
        self.soundFileURLRef = (__bridge CFURLRef)soundURL;
        AudioServicesCreateSystemSoundID(self.soundFileURLRef, &(_soundFileObject));
        self.identifier = [fileName copy];
        // Needs logic to take the sound file and get the color for it, and also set a secondary color if there is one
    }
    return self;
}

-(instancetype)initWithSoundFileNamed:(NSString *)fileName andFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor {
    self = [super init];
    
    if(self) {
        NSURL * soundURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"]];
        self.soundFileURLRef = (__bridge CFURLRef)soundURL;
        AudioServicesCreateSystemSoundID(self.soundFileURLRef, &(_soundFileObject));
        self.identifier = [fileName copy];
        // Needs logic to take the sound file and get the color for it, and also set a secondary color if there is one
        self.soundColor = firstColor;
        if(secondColor != nil){
            self.secondaryColor = secondColor;
            self.hasSecondaryColor = YES;
        } else {
            self.secondaryColor = [UIColor whiteColor];
            self.hasSecondaryColor = NO;
        }
    }
    return self;
}

-(void)playSound {
    AudioServicesPlaySystemSound(self.soundFileObject);
}

@end
