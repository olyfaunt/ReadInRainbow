//
//  ViewController.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCell.h"
#import "ChartCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "MainMenuReturnProtocol.h"

@interface MainViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MainMenuReturnProtocol>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *chartCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *gamesCollectionView;

@property (nonatomic) NSArray *soundsArray;
@property (nonatomic) NSArray *consonants;
@property (nonatomic) NSArray *vowels;
@property (nonatomic) NSMutableArray *consonantSounds;
@property (nonatomic) NSMutableArray *vowelSounds;
@property (nonatomic, assign) int numberOfGames;
@property (nonatomic) NSMutableArray *gameTitlesArray;
@property (nonatomic) NSArray *gameImagesArray;
@property (nonatomic) AVAudioPlayer *soundPlayer;
@end

