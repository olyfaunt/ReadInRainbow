//
//  WordLibrary.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordLibrary : NSObject
@property (nonatomic, strong) NSDictionary *wordLibrary;

+ (id)sharedLibrary;

@end
