//
//  UIButton+LetterButton.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "UIButton+setTag.h"

@implementation UIButton (setTag)

@dynamic tagString;

-(void)setTagString:(NSString *)tagString {
    self.tagString = tagString;
}

@end
