//
//  ChartCell.h
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorBlockView.h"

@interface ChartCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet ColorBlockView *colourView;

@end
