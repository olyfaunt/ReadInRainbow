//
//  Game2ViewController.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Game2ViewController : UIViewController

@property (nonatomic, strong) NSArray * soundsArray;
@property (weak, nonatomic) IBOutlet UIImageView *livesImageView;
- (IBAction)gameOver:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *gameOverButton;

@end
