//
//  MainMenuReturnProtocol.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-28.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MainMenuReturnProtocol <NSObject>

- (void)returnToMainMenu:(UIViewController *)oldViewController;

@end
