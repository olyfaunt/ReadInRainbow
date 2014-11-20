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
@dynamic tagString, customState;

-(void)setTagString:(NSString *)tagString {
    objc_setAssociatedObject(self, @selector(tagString), tagString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)tagString {
    return objc_getAssociatedObject(self, @selector(tagString));
}
//
//- (void)setOutlined:(BOOL)outlined
//{
//    if (outlined)
//    {
//        self.customState |= UIControlStateOutlined;
//    }
//    else
//    {
//        self.customState &= ~UIControlStateOutlined;
//    }
//    [self stateWasUpdated];
//}
//
//- (BOOL)outlined
//{
//    return ( self.customState & UIControlStateOutlined ) == UIControlStateOutlined;
//}
//
//- (UIControlState)state {
//    return [super state] | self.customState;
//}
//
//- (void)stateWasUpdated
//{
//    [self setNeedsLayout];
//}
//

@end