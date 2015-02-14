//
//  FifteenBoardView.m
//  15puzzle
//
//  Created by Adam Matthew Bennett on 2/11/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "FifteenBoardView.h"
#import "AppDelegate.h"
#import "FifteenBoard.h"

@implementation FifteenBoardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    FifteenBoard *board = appDelegate.board;
    
    const CGRect boardRect = [self boardRect];
    const CGFloat tileSize = boardRect.size.width/4;
    const CGRect tileBounds = CGRectMake(0, 0, tileSize, tileSize);
    
    for(int row = 0; row < 4; row++){
        for(int col = 0; col < 4; col++){
            const int tile = [board getTileAtRow:row Column:col];
            if(tile > 0){
                UIButton *button = (UIButton*) [self viewWithTag:tile];
                button.bounds = tileBounds;
                button.center = CGPointMake(boardRect.origin.x + (col + 0.5)*tileSize, boardRect.origin.y + (row + 0.5)*tileSize);
            }
        }
    }
}

-(CGRect)boardRect{
    const CGFloat W = self.bounds.size.width;
    const CGFloat H = self.bounds.size.height;
    const CGFloat margin = 10;
    const CGFloat size = ((W <= H) ? W : H) - 2*margin;
    const CGFloat boardSize = ((int)size/4)*4.0;
    const CGFloat leftMargin = (W - boardSize)/2;
    const CGFloat topMargin = (H - boardSize)/2;
    return CGRectMake(leftMargin, topMargin, boardSize, boardSize);
}

@end
