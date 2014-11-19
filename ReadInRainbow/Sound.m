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
        NSError * error;
        self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
        NSLog(@"AudioPlayer error is %@", error);
        //NSAssert((error == nil),@"AVAudioPlayer failed to initialize");
        self.audioPlayer.volume=1.0f; //between 0 and 1
        self.identifier = [fileName copy];
        // Needs logic to take the sound file and get the color for it, and also set a secondary color if there is one
    }
    return self;
}

-(instancetype)initWithSoundFileNamed:(NSString *)fileName andFirstColor:(UIColor *)firstColor andSecondColor:(UIColor *)secondColor {
    self = [super init];
    
    if(self) {
        NSURL * soundURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"]];
        NSError * error;
        self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
        self.audioPlayer.volume=1.0f;
        NSLog(@"AudioPlayer error is %@", error);
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
    [self.audioPlayer prepareToPlay];
    self.audioPlayer.numberOfLoops=0; //or more if needed
    
    [self.audioPlayer play];
}

@end
