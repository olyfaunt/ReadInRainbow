//
//  Word.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Word : NSObject

@property (nonatomic, strong) NSArray * phonemeArray;
@property (nonatomic) NSString *wordString;
@property (nonatomic, assign) int numberOfLetters;
@property (nonatomic, assign) CGSize stringSize;

- (instancetype)initWithPhonemeArray:(NSArray *)phonemeArray;
- (NSAttributedString *)buildAttributedStringFromPhonemeArray;

@end
