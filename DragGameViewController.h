//
//  DragGameViewController.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-20.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragColorView.h"
#import "Word.h"
#import "WordLibrary.h"
#import "Phoneme.h"
#import "UIButton+setTag.h"
#import "Sound.h"
#import "SoundLibrary.h"
#import "ChartCell.h"
#import "ColorBlockView.h"
#import "Util.h"
#import "AppDelegate.h"

@interface DragGameViewController : UIViewController <DragColorViewDragDelegateProtocol>

@property (nonatomic) NSArray *soundsArray;
@property (nonatomic) NSMutableArray *colorBlocksArray;
@property (nonatomic) CGFloat startingXPosition;
@property (nonatomic) NSArray *colorBlockOptions;
@property (nonatomic) Word *currentWord;
@property (nonatomic, weak) UIButton *nextWordButton;
@property (nonatomic, assign) int placeInPhonemeArray;
@property (nonatomic) NSMutableArray *buttonsArray;
@property (nonatomic) AVAudioPlayer *soundPlayer;
@property (nonatomic) AVAudioPlayer *wordPlayer;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@property (nonatomic) int NumberOfChoices;
- (IBAction)goToMenu:(id)sender;
- (IBAction)playWordSound:(id)sender;

@end
