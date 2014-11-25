//
//  DragGameViewController.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-20.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "DragGameViewController.h"

@interface DragGameViewController ()

@end

@implementation DragGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
