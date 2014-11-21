//
//  GameCell.m
//  ReadInRainbow
//
//  Created by Audrey Jun on 2014-11-17.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "GameCell.h"

@implementation GameCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.gameView.image = [UIImage imageNamed:@"selectedtesticon"];
    } else {
        self.gameView.image = [UIImage imageNamed:@"testicon"];
    }
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.gameView.image = [UIImage imageNamed:@"selectedtesticon"];
    } else {
        self.gameView.image = [UIImage imageNamed:@"testicon"];
    }
}

@end
