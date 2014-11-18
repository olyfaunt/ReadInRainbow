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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView == self.chartCollectionView)
    {
        //return cell for chartCollectionView
        return 48;
    }
    else
    {
        //return cell for gamesCollectionview
        return 20;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView == self.chartCollectionView)
    {
//        Sound *sound = self.soundsArray[indexPath.item];
        ChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        
//        if (sound.secondaryColor==[UIColor colorWithRed:1.000f green:1.000f blue:1.000f alpha:1.00f]) {
//            cell.colourView.backgroundColor = sound.soundColor;
//        } else {
//            CAGradientLayer *gradient = [CAGradientLayer layer];
//            gradient.frame = cell.colourView.frame;
//            gradient.colors = [NSArray arrayWithObjects:(id)[sound.soundColor CGColor], (id)[sound.secondaryColor CGColor], nil];
//            [cell.colourView.layer insertSublayer:gradient atIndex:0];
//        }

        if (indexPath.row > 5) {
            //do not assign .secondColor if none
            cell.colourView.firstColor = [UIColor blueColor];
        } else {
            
            cell.colourView.firstColor = [UIColor purpleColor];
            cell.colourView.secondColor = [UIColor orangeColor];
//            CAGradientLayer *gradient = [CAGradientLayer layer];
//            gradient.frame = cell.colourView.bounds;
//            gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor], (id)[[UIColor yellowColor] CGColor], nil];
//            [cell.colourView.layer insertSublayer:gradient atIndex:0];
        }
    
        return cell;

    }
    else
    {
        GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
        return cell;
    }

}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    //get index path of cell
    //get and play associated sound item that relates to index path

    NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"ah" ofType:@"caf"];
    NSURL *defaultURL = [NSURL fileURLWithPath:defaultPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)defaultURL, &_defaultSound);
    AudioServicesPlaySystemSound(self.defaultSound);
    
}

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
