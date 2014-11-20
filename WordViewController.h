//
//  WordViewController.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordViewController : UIViewController
@property (nonatomic, strong) NSArray *soundsArray;
@property (nonatomic) NSArray *wordsArray;
- (IBAction)goToMenu:(id)sender;
- (IBAction)backWord:(id)sender;
- (IBAction)nextWord:(id)sender;
- (IBAction)playWord:(id)sender;
- (IBAction)changeTest:(id)sender;

@end
