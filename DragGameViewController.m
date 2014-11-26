//
//  DragGameViewController.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-20.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "DragGameViewController.h"
#import "Word.h"
#import "Phoneme.h"
#import "UIButton+setTag.h"
#import "WordLibrary.h"
#import "Sound.h"
#import "SoundLibrary.h"
#import "DragColorView.h"
#import "Util.h"
#import "DragCell.h"

@interface DragGameViewController ()

@end

@implementation DragGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollectionView];
    // Do any additional setup after loading the view.
    
    ///////////when make array of answer DragColorViews, set dragColorView.dragDelegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dragColorView:(DragColorView *)dragColorView didDragToPoint:(CGPoint)pt {
    //a tile was dragged, check if matches a target
//    TargetView* targetView = nil;
    
//    The simple if statement effectively checks if the tile’s center point was dropped within the target – that is, whether the tile was dropped on a target. And because the point passed to this method is the tile’s center, the method will not succeed if only a small portion of the tile is within the target.
    //    for (TargetView* tv in _targets) {
//        if (CGRectContainsPoint(tv.frame, pt)) {
//            targetView = tv;
//            break;
//        }
//    }
    
//    //1 check if target was found
//    if (targetView!=nil) {
//        
//        //2 check if letter matches
//        if ([targetView.letter isEqualToString: tileView.letter]) {
//            
//            //3
//            NSLog(@"Success! You should place the tile here!");
//            
//            //more stuff to do on success here
//            
//            NSLog(@"Check if the player has completed the phrase");
//        } else {
//            //4
//            NSLog(@"Failure. Let the player know this tile doesn't belong here.");
//            
//            //more stuff to do on failure here        
//        }
//    }
    NSLog(@"To implement");
}

- (void)setUpCollectionView {
    self.colorPickerCollectionView.delegate = self;
    self.colorPickerCollectionView.dataSource = self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.soundsArray.count;
}


-(DragCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DragCell * newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Sound *soundForCell = self.soundsArray[indexPath.row];
    newCell.dragColorView.firstColor = soundForCell.soundColor;
    if(soundForCell.hasSecondaryColor) {
        newCell.dragColorView.secondColor = soundForCell.secondaryColor;
    } else {
        newCell.dragColorView.secondColor = nil;
    }
    [newCell.dragColorView setNeedsDisplay]; //
    return newCell;
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    Sound * soundAtCell = self.collectionViewOptions[indexPath.item];
//    NSError * error = nil;
//    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundAtCell.soundURL error:&error];
//    self.soundPlayer.volume=1.0f;
//    [self.soundPlayer prepareToPlay];
//    self.soundPlayer.numberOfLoops=0; //or more if needed
//    [self.soundPlayer play];
//    if(self.placeInPhonemeArray >= self.currentWord.phonemeArray.count) {
//        // do nothing
//    } else if([[self.currentWord.phonemeArray[self.placeInPhonemeArray] soundIdentifier] isEqualToString:soundAtCell.identifier]){
//        [self lightUpPhonemeInWordForSound:soundAtCell];
//        self.placeInPhonemeArray++;
//        if(self.placeInPhonemeArray >= self.currentWord.phonemeArray.count){
//            [self displayNextWordButton];
//        }
//    } else {
//        [self loseOneLife];
//    }
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
