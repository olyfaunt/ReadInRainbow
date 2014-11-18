//
//  ColorBlockView.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "ColorBlockView.h"

@implementation ColorBlockView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (self.secondColor) {
        CGRect topRect = CGRectMake(0, 0, rect.size.width, rect.size.height/2.0);
        [self.firstColor setFill];
        UIRectFill( topRect );
        
        CGRect bottomRect = CGRectMake(0, rect.size.height/2.0, rect.size.width, rect.size.height/2.0);
        [self.secondColor setFill];
        UIRectFill( bottomRect );
    } else {
        CGRect wholeRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
        [self.firstColor setFill];
        UIRectFill( wholeRect );
    }
}



@end
