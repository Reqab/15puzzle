//
//  FifteenBoard.h
//  15puzzle
//
//  Created by Adam Matthew Bennett on 2/11/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FifteenBoard : UIView

@property (strong, nonatomic) NSMutableArray *numbers;

-(NSString*)sandBoxFileName;
-(void)saveBoard;
-(void)loadBoard;
-(instancetype)init;
-(void)scramble:(int)n;
-(int)getTileAtRow:(int)row Column:(int)col;
-(void)getRow:(int*)row Column:(int*)col ForTile:(int)tile;
-(BOOL)isSolved;
-(BOOL)canSlideTileUpAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileDownAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileLeftAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileRightAtRow:(int)row Column:(int)col;
-(void)slideTileAtRow:(int)row Column:(int)col;

@end
