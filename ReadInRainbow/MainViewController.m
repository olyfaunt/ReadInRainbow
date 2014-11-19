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
#import "Game3ViewController.h"

@interface MainViewController ()

@property (assign) SystemSoundID defaultSound;

@end

@implementation MainViewController

static NSString * const reuseIdentifier = @"ChartCell";
static NSString * const reuseIdentifier2 = @"GameCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.chartCollectionView.delegate = self;
    self.gamesCollectionView.delegate = self;
    self.chartCollectionView.dataSource = self;
    self.gamesCollectionView.dataSource = self;
    
//    SoundLibrary *soundDictionary = [[SoundLibrary alloc] init];
//    self.soundsArray = [soundDictionary.soundLibrary allValues];
//    Sound * ahh = [[SoundLibrary sharedLibrary] soundLibrary][@"ahh"];
    self.soundsArray = [[[SoundLibrary sharedLibrary] soundLibrary] allValues];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        return 15;
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
        [cell.colourView setNeedsDisplay]; //to redraw rect!!!!!!
        return cell;
    }
    else
    {
        GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
        cell.backgroundView.backgroundColor = [UIColor grayColor];
        cell.gameLabel.text = @"Test Game Name";
        cell.gameView.contentMode = UIViewContentModeScaleAspectFill;
        cell.gameView.clipsToBounds = YES;
        cell.gameView.image = [UIImage imageNamed:@"testicon"];
        return cell;
    }
    
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    //get index path of cell
    //get and play associated sound item that relates to index path
    if(collectionView == self.chartCollectionView)
    {
        Sound *sound = self.soundsArray[indexPath.row];
        [sound playSound];
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
                Game2ViewController *game2VC = [[UIStoryboard storyboardWithName:@"Game2Storyboard.storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Game2ViewController"];
                game2VC.soundsArray = self.soundsArray;
                AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
                appDelegateTemp.window.rootViewController = game2VC;
                break;
            }
            case 2:
            {
                Game3ViewController *game3VC = [[UIStoryboard storyboardWithName:@"Game3Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Game3ViewController"];
                game3VC.soundsArray = self.soundsArray;
                AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
                appDelegateTemp.window.rootViewController = game3VC;
                break;
            }
            default:
                break;
        }
        
        
        
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
