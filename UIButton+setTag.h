//
//  UIButton+LetterButton.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (setTag)
@property(nonatomic, retain) NSString *tagString;
@property (nonatomic) BOOL outlined;
@property UIControlState customState;
-(void)setTagString:(NSString *)tagString;
@end