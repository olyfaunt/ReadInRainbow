//
//  ViewController.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "MainViewController.h"
#import "SoundLibrary.h"
#import "Sound.h"
#import "Phoneme.h"
#import "Word.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ColorBlockView.h"
#import "AppDelegate.h"
#import "Game1ViewController.h"
#import "Game2ViewController.h"
#import "DragGameViewController.h"
#import "WordViewController.h"
#import "Util.h"
#import "HangmanViewController.h"

@interface MainViewController ()

@property (assign) SystemSoundID defaultSound;

@end

@implementation MainViewController

static NSString * const reuseIdentifier = @"ChartCell";
static NSString * const reuseIdentifier2 = @"GameCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.chartCollectionView.layer.masksToBounds = YES;
    self.chartCollectionView.layer.cornerRadius = 10;
    self.chartCollectionView.delegate = self;
    self.gamesCollectionView.delegate = self;
    self.chartCollectionView.dataSource = self;
    self.gamesCollectionView.dataSource = self;

    [self setUpArrayOfSounds];
    [self setUpArrayOfGameImages];
    
    self.numberOfGames = NumberOfGames;
    self.gameTitlesArray = [NSMutableArray new];
    for (int i = 1; i <= self.numberOfGames; i++) {
        NSString *gameName = [NSString stringWithFormat:@"%d", i];
        [self.gameTitlesArray addObject:gameName];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        // orientation is landscape
        NSLog(@"init to wide");
        [self doSameAdjust:true];
        
    }  else {
        // orientation is portrait
        NSLog(@"init to tall");
        [self doSameAdjust:false];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpArrayOfSounds {
    self.consonants = @[@"b", @"ch", @"d", @"f", @"g", @"h", @"je", @"zh", @"k", @"el", @"m", @"n", @"ng", @"p", @"r", @"s", @"sh", @"t", @"th", @"thth", @"v", @"w", @"yod", @"z"];
    self.vowels = @[@"ah", @"ahh", @"ar", @"au", @"eh", @"er", @"euh", @"ih", @"ir", @"longa", @"longe", @"longi", @"longo", @"oo", @"or", @"our", @"oy", @"schwa", @"schwar", @"uh", @"ur", @"weaki", @"weaku"];
    self.consonantSounds = [NSMutableArray new];
    for (NSString *letter in self.consonants) {
        Sound *soundForLetter = [[SoundLibrary sharedLibrary] soundLibrary][letter];
        [self.consonantSounds addObject:soundForLetter];
    }
    self.vowelSounds = [NSMutableArray new];
    for (NSString *letter in self.vowels) {
        Sound *soundForLetter = [[SoundLibrary sharedLibrary] soundLibrary][letter];
        [self.vowelSounds addObject:soundForLetter];
    }
    self.soundsArray = [self.consonantSounds arrayByAddingObjectsFromArray:self.vowelSounds];
}

-(void) setUpArrayOfGameImages {
    UIImage *reviewImage = [UIImage imageNamed:@"review"];
    UIImage *gameImage = [UIImage imageNamed:@"game"];
    UIImage *puzzleImage = [UIImage imageNamed:@"puzzle"];
    
    self.gameImagesArray = @[reviewImage,gameImage,puzzleImage,gameImage];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    //making change for commit
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView == self.chartCollectionView)
    {
        //return cell for chartCollectionView
        return self.soundsArray.count;
    }
    else
    {
        //return cell for gamesCollectionview
        return 4;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView == self.chartCollectionView)
    {
        ChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        Sound *sound = self.soundsArray[indexPath.row];
        if (!sound.hasSecondaryColor) {
            [cell.colourView setFirstColor:sound.soundColor];
            cell.colourView.secondColor = nil;
        } else {
            [cell.colourView setFirstColor:sound.soundColor];
            cell.colourView.secondColor = sound.secondaryColor;
        }
        UITapGestureRecognizer * doubleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTappedOnChartCell:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        [cell addGestureRecognizer:doubleTapRecognizer];
        [cell.colourView setNeedsDisplay]; //to redraw rect!!!!!!
        cell.soundIdentifier = sound.identifier;
        cell.colourView.layer.masksToBounds = YES;
        cell.colourView.layer.cornerRadius = 5;
        return cell;
    }
    else
    {
        GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
        cell.backgroundView.backgroundColor = [UIColor grayColor];
        cell.gameLabel.text = self.gameTitlesArray[indexPath.row];
        cell.gameLabel.textColor = [UIColor clearColor];
        cell.gameView.contentMode = UIViewContentModeScaleAspectFill;
        cell.gameView.clipsToBounds = YES;
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 30;
        cell.gameView.image = self.gameImagesArray[indexPath.row];
        return cell;
    }
    
}

- (void)doubleTappedOnChartCell:(id)sender {
    UITapGestureRecognizer * gestureRecognizer = sender;
    ChartCell * cell = (ChartCell *)gestureRecognizer.view;
    Game1ViewController *game1VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Game1ViewController"];
    game1VC.soundsArray = self.soundsArray;
    game1VC.shouldGoToSpecificSound = YES;
    game1VC.soundIdentifier = cell.soundIdentifier;
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = game1VC;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    //get index path of cell
    //get and play associated sound item that relates to index path
    if(collectionView == self.chartCollectionView)
    {
        Sound *sound = self.soundsArray[indexPath.row];
        NSError *error;
        self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:sound.soundURL error:&error];
        self.soundPlayer.volume=1.0f;
        [self.soundPlayer prepareToPlay];
        self.soundPlayer.numberOfLoops=0; //or more if needed
        [self.soundPlayer play];
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                Game1ViewController *game1VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Game1ViewController"];
                game1VC.soundsArray = self.soundsArray;
                AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
                appDelegateTemp.window.rootViewController = game1VC;
                break;
            }
            case 1:
            {
                Game2ViewController *game2VC = [[UIStoryboard storyboardWithName:@"Game2Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Game2ViewController"];
                game2VC.soundsArray = self.soundsArray;
                AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
                appDelegateTemp.window.rootViewController = game2VC;
                break;
            }
            case 2:
            {
                DragGameViewController *dragVC = [[UIStoryboard storyboardWithName:@"DragGameStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"DragGameViewController"];
                dragVC.soundsArray = self.soundsArray;
                AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
                appDelegateTemp.window.rootViewController = dragVC;
                break;
            }
            case 3:
            {
                HangmanViewController * hangVC = [[UIStoryboard storyboardWithName:@"HangmanStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"HangmanViewController"];
                AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
                appDelegateTemp.window.rootViewController = hangVC;
                break;
            }
            default:
                break;
        }
        
        
        
    }
}

//delegate - rotate
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"transition to :%f and heigh %f",size.width, size.height);
    BOOL transitionToWide = size.width > size.height;
    if (transitionToWide){
        NSLog(@"rotate to wide");
        [self doSameAdjust:true];
    }
    else {
        NSLog(@"rotate to tall");
        [self doSameAdjust:false];
    }
}



-(void)doSameAdjust:(BOOL)isWide
{
    if (isWide){
        self.heightConstraint.constant = 470;
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
    else {
        
        self.heightConstraint.constant = 720;
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}


//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [collectionView.collectionViewLayout invalidateLayout];
//}

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */


@end
