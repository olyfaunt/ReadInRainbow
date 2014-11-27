//
//  DragGameDelegateProtocol.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-27.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DragColorViewController;
@class DragColorView;

@protocol DragGameDelegateProtocol <NSObject>

- (void)addDynamicBehaviour:(DragColorView *)dragColorView;

@end
