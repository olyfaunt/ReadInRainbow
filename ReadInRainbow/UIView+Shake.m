//
//  UIView+Shake.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-26.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)


- (void)shakeView:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 0.1;
    animation.byValue = @(20);
    animation.autoreverses = YES;
    animation.repeatCount = 3;
    [view.layer addAnimation:animation forKey:@"Shake"];
}

@end
