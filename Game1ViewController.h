//
//  Game1ViewController.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-18.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorBlockView.h"

@interface Game1ViewController : UIViewController
@property (nonatomic) NSArray *soundsArray;
@property (weak, nonatomic) IBOutlet ColorBlockView *colorView;
- (IBAction)playNext:(id)sender;
- (IBAction)goToMenu:(id)sender;
- (IBAction)clickedColor:(id)sender;

@end
