//
//  UIButton+LetterButton.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "UIButton+setTag.h"
#import <objc/runtime.h>


@implementation UIButton (setTag)
@dynamic tagString;

-(void)setTagString:(NSString *)tagString {
    objc_setAssociatedObject(self, @selector(tagString), tagString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)tagString {
    return objc_getAssociatedObject(self, @selector(tagString));
}
@end