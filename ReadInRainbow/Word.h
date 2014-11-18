//
//  Word.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

@property (nonatomic, strong) NSArray * phonemeArray;

- (instancetype)initWithPhonemeArray:(NSArray *)phonemeArray;
- (NSAttributedString *)buildAttributedStringFromPhonemeArray;

@end
