//
//  DragColorView.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-25.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "DragColorView.h"

@implementation DragColorView{
    //use _xOffset and _yOffset to keep track of the distance between the center of the tile and the initial placement of the user’s finger when the touch began
    int _xOffset, _yOffset;
}

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
    
    self.userInteractionEnabled = YES;
}

#pragma mark - dragging the color block
//1
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    _xOffset = pt.x - self.center.x;
    _yOffset = pt.y - self.center.y;
}

//2
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    self.center = CGPointMake(pt.x - _xOffset, pt.y - _yOffset);
}

//3
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    
    if (self.dragDelegate) {
        [self.dragDelegate addDynamicBehaviour:self]; ///////// have it snap back
        [self.dragDelegate dragColorView:self didDragToPoint:self.center];
    }
}

- (void)addDynamicBehaviour:(DragColorView *)dragColorView {
    [self.animator removeAllBehaviors];
    dragColorView.isSnapEnabled = YES;
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:dragColorView snapToPoint:dragColorView.originalPoint];
    [self.animator addBehavior:self.snapBehavior];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
