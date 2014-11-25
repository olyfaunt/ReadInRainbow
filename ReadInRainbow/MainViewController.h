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

@interface MainViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *chartCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *gamesCollectionView;

@property (nonatomic) NSArray *soundsArray;
@property (nonatomic, assign) int numberOfGames;
@property (nonatomic) NSMutableArray *gameTitlesArray;
@property (nonatomic) AVAudioPlayer *soundPlayer;
@end

