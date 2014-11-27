//
//  DragColorView.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-25.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DragColorView;

@protocol DragColorViewDragDelegateProtocol <NSObject>

-(void)dragColorView:(DragColorView*)dragColorView didDragToPoint:(CGPoint)pt;

@end

@interface DragColorView : UIView

//make the game controller a delegate to all tiles. The tiles will then invoke a method on their delegate when the player drops them.
@property (weak, nonatomic) id<DragColorViewDragDelegateProtocol> dragDelegate;
@property (nonatomic, strong) UIColor *firstColor;
@property (nonatomic, strong) UIColor *secondColor;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, assign) CGPoint originalPoint;
@property (nonatomic, assign) BOOL isMatched;
@end
