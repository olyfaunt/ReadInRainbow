//
//  Util.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-20.
//  Copyright (c) 2014 ajek. All rights reserved.
//

//to add: k in front of Constants
static const int FontSize = 115;
static const int Spacing = 30;
static const float StrokeWidth = -6.0;
static const int NumberOfGames = 15;
static const int NumberOfButtons = 3;

#define kScreenWidth [UIScreen mainScreen].bounds.size.height
#define kScreenHeight [UIScreen mainScreen].bounds.size.width

#define kBlockMargin 20
#define kBlockWidth 50
#define kBlockHeight 50

#import <Foundation/Foundation.h>

@interface Util : NSObject

@end
