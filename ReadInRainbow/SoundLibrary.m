//
//  SoundLibrary.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "SoundLibrary.h"
#import "Sound.h"

@implementation SoundLibrary

-(instancetype)init {
    self = [super init];
    if(self) {
        self.soundLibrary = @{
                              @"longa":[Sound SoundWithSoundFileNamed:@"longa" andFirstColor:[UIColor colorWithRed:0.514f green:0.878f blue:0.169f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.973f green:0.714f blue:0.753f alpha:1.00f]],
                              @"longi":[Sound SoundWithSoundFileNamed:@"longi" andFirstColor:[UIColor colorWithRed:1.000f green:1.000f blue:1.000f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.973f green:0.714f blue:0.753f alpha:1.00f]],
                              @"oy":[Sound SoundWithSoundFileNamed:@"oy" andFirstColor:[UIColor colorWithRed:0.612f green:0.314f blue:0.133f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.973f green:0.714f blue:0.753f alpha:1.00f]],
                              @"au":[Sound SoundWithSoundFileNamed:@"au" andFirstColor:[UIColor colorWithRed:1.000f green:1.000f blue:1.000f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.741f green:0.882f blue:0.851f alpha:1.00f]],
                              @"longo":[Sound SoundWithSoundFileNamed:@"longo" andFirstColor:[UIColor colorWithRed:0.612f green:0.314f blue:0.133f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.741f green:0.882f blue:0.851f alpha:1.00f]],
                              @"ir":[Sound SoundWithSoundFileNamed:@"ir" andFirstColor:[UIColor colorWithRed:0.933f green:0.314f blue:0.557f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.973f green:0.655f blue:0.396f alpha:1.00f]],
                              @"er":[Sound SoundWithSoundFileNamed:@"er" andFirstColor:[UIColor colorWithRed:0.514f green:0.878f blue:0.169f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.973f green:0.655f blue:0.396f alpha:1.00f]],
                              @"our":[Sound SoundWithSoundFileNamed:@"our" andFirstColor:[UIColor colorWithRed:0.675f green:0.561f blue:0.553f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.973f green:0.655f blue:0.396f alpha:1.00f]],
                              @"ar":[Sound SoundWithSoundFileNamed:@"ar" andFirstColor:[UIColor colorWithRed:1.000f green:1.000f blue:1.000f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.973f green:0.655f blue:0.396f alpha:1.00f]],
                              @"or":[Sound SoundWithSoundFileNamed:@"or" andFirstColor:[UIColor colorWithRed:0.612f green:0.314f blue:0.133f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.973f green:0.655f blue:0.396f alpha:1.00f]],
                              @"ih":[Sound SoundWithSoundFileNamed:@"ih" andFirstColor:[UIColor colorWithRed:0.933f green:0.314f blue:0.557f alpha:1.00f] andSecondColor:nil],
                              @"eh":[Sound SoundWithSoundFileNamed:@"eh" andFirstColor:[UIColor colorWithRed:0.514f green:0.878f blue:0.169f alpha:1.00f] andSecondColor:nil],
                              @"ah":[Sound SoundWithSoundFileNamed:@"ah" andFirstColor:[UIColor colorWithRed:0.871f green:0.576f blue:0.557f alpha:1.00f] andSecondColor:nil],
                              @"euh":[Sound SoundWithSoundFileNamed:@"euh" andFirstColor:[UIColor colorWithRed:0.675f green:0.561f blue:0.553f alpha:1.00f] andSecondColor:nil],
                              @"uh":[Sound SoundWithSoundFileNamed:@"uh" andFirstColor:[UIColor colorWithRed:0.996f green:0.918f blue:0.369f alpha:1.00f] andSecondColor:nil],
                              @"longe":[Sound SoundWithSoundFileNamed:@"longe" andFirstColor:[UIColor colorWithRed:0.918f green:0.125f blue:0.176f alpha:1.00f] andSecondColor:nil],
                              @"ur":[Sound SoundWithSoundFileNamed:@"ur" andFirstColor:[UIColor colorWithRed:0.945f green:0.459f blue:0.533f alpha:1.00f] andSecondColor:nil],
                              @"oo":[Sound SoundWithSoundFileNamed:@"oo" andFirstColor:[UIColor colorWithRed:0.071f green:0.545f blue:0.282f alpha:1.00f] andSecondColor:nil],
                              @"ahh":[Sound SoundWithSoundFileNamed:@"ahh" andFirstColor:[UIColor colorWithRed:1.000f green:1.000f blue:1.000f alpha:1.00f] andSecondColor:nil],
                              @"yod":[Sound SoundWithSoundFileNamed:@"yod" andFirstColor:[UIColor colorWithRed:0.953f green:0.604f blue:0.690f alpha:1.00f] andSecondColor:nil],
                              @"r":[Sound SoundWithSoundFileNamed:@"r" andFirstColor:[UIColor colorWithRed:0.949f green:0.510f blue:0.192f alpha:1.00f] andSecondColor:nil],
                              @"w":[Sound SoundWithSoundFileNamed:@"w" andFirstColor:[UIColor colorWithRed:0.486f green:0.796f blue:0.749f alpha:1.00f] andSecondColor:nil],
                              @"f":[Sound SoundWithSoundFileNamed:@"f" andFirstColor:[UIColor colorWithRed:0.694f green:0.604f blue:0.784f alpha:1.00f] andSecondColor:nil],
                              @"p":[Sound SoundWithSoundFileNamed:@"p" andFirstColor:[UIColor colorWithRed:0.639f green:0.165f blue:0.149f alpha:1.00f] andSecondColor:nil],
                              @"th":[Sound SoundWithSoundFileNamed:@"th" andFirstColor:[UIColor colorWithRed:0.867f green:0.906f blue:0.620f alpha:1.00f] andSecondColor:nil],
                              @"t":[Sound SoundWithSoundFileNamed:@"t" andFirstColor:[UIColor colorWithRed:0.843f green:0.192f blue:0.565f alpha:1.00f] andSecondColor:nil],
                              @"ch":[Sound SoundWithSoundFileNamed:@"ch" andFirstColor:[UIColor colorWithRed:0.843f green:0.192f blue:0.565f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.110f green:0.678f blue:0.863f alpha:1.00f]],
                              @"s":[Sound SoundWithSoundFileNamed:@"s" andFirstColor:[UIColor colorWithRed:0.557f green:0.773f blue:0.345f alpha:1.00f] andSecondColor:nil],
                              @"sh":[Sound SoundWithSoundFileNamed:@"sh" andFirstColor:[UIColor colorWithRed:0.110f green:0.678f blue:0.863f alpha:1.00f] andSecondColor:nil],
                              @"k":[Sound SoundWithSoundFileNamed:@"k" andFirstColor:[UIColor colorWithRed:0.980f green:0.722f blue:0.318f alpha:1.00f] andSecondColor:nil],
                              @"v":[Sound SoundWithSoundFileNamed:@"v" andFirstColor:[UIColor colorWithRed:0.675f green:0.580f blue:0.118f alpha:1.00f] andSecondColor:nil],
                              @"b":[Sound SoundWithSoundFileNamed:@"b" andFirstColor:[UIColor colorWithRed:0.071f green:0.494f blue:0.471f alpha:1.00f] andSecondColor:nil],
                              @"thth":[Sound SoundWithSoundFileNamed:@"thth" andFirstColor:[UIColor colorWithRed:0.847f green:0.373f blue:0.522f alpha:1.00f] andSecondColor:nil],
                              @"d":[Sound SoundWithSoundFileNamed:@"d" andFirstColor:[UIColor colorWithRed:0.110f green:0.631f blue:0.286f alpha:1.00f] andSecondColor:nil],
                              @"g":[Sound SoundWithSoundFileNamed:@"g" andFirstColor:[UIColor colorWithRed:0.110f green:0.631f blue:0.286f alpha:1.00f] andSecondColor:[UIColor colorWithRed:0.059f green:0.431f blue:0.639f alpha:1.00f]],
                              @"z":[Sound SoundWithSoundFileNamed:@"z" andFirstColor:[UIColor colorWithRed:0.694f green:0.345f blue:0.620f alpha:1.00f] andSecondColor:nil],
                              @"zh":[Sound SoundWithSoundFileNamed:@"zh" andFirstColor:[UIColor colorWithRed:0.059f green:0.431f blue:0.639f alpha:1.00f] andSecondColor:nil],
                              @"je":[Sound SoundWithSoundFileNamed:@"je" andFirstColor:[UIColor colorWithRed:0.604f green:0.608f blue:0.624f alpha:1.00f] andSecondColor:nil],
                              @"m":[Sound SoundWithSoundFileNamed:@"m" andFirstColor:[UIColor colorWithRed:0.929f green:0.314f blue:0.180f alpha:1.00f] andSecondColor:nil],
                              @"n":[Sound SoundWithSoundFileNamed:@"n" andFirstColor:[UIColor colorWithRed:0.490f green:0.471f blue:0.710f alpha:1.00f] andSecondColor:nil],
                              @"ng":[Sound SoundWithSoundFileNamed:@"ng" andFirstColor:[UIColor colorWithRed:0.475f green:0.443f blue:0.078f alpha:1.00f] andSecondColor:nil],
                              @"h":[Sound SoundWithSoundFileNamed:@"h" andFirstColor:[UIColor colorWithRed:0.816f green:0.902f blue:0.878f alpha:1.00f] andSecondColor:nil],
                              @"el":[Sound SoundWithSoundFileNamed:@"el" andFirstColor:[UIColor colorWithRed:0.078f green:0.518f blue:0.741f alpha:1.00f] andSecondColor:nil],
                              @"weaki":[Sound SoundWithSoundFileNamed:@"weaki" andFirstColor:[UIColor colorWithRed:0.969f green:0.718f blue:0.753f alpha:1.00f] andSecondColor:nil],
                              @"schwar":[Sound SoundWithSoundFileNamed:@"schwar" andFirstColor:[UIColor colorWithRed:0.973f green:0.655f blue:0.396f alpha:1.00f] andSecondColor:nil],
                              @"weaku":[Sound SoundWithSoundFileNamed:@"weaku" andFirstColor:[UIColor colorWithRed:0.749f green:0.890f blue:0.863f alpha:1.00f] andSecondColor:nil],
                              @"schwa":[Sound SoundWithSoundFileNamed:@"schwa" andFirstColor:[UIColor colorWithRed:0.925f green:0.882f blue:0.573f alpha:1.00f] andSecondColor:nil]};
    }
    return self;
}

@end
