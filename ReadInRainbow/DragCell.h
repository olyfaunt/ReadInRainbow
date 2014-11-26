//
//  DragCell.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-26.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragColorView.h"

@interface DragCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet DragColorView *dragColorView;

@end
