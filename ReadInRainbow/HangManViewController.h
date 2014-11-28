//
//  HangManViewController.h
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-21.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuReturnProtocol.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HangmanViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id <MainMenuReturnProtocol> MainMenuReturnDelegate;

@property (strong, nonatomic) MPMoviePlayerViewController *moviePlayer;
- (IBAction)playMovie:(id)sender;

@end
