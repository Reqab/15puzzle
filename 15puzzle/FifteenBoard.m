//
//  FifteenBoard.m
//  15puzzle
//
//  Created by Adam Matthew Bennett on 2/11/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "FifteenBoard.h"

@implementation FifteenBoard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if(self = [super init]){
        self.numbers = [[NSMutableArray alloc] initWithCapacity:16];
        for (int i = 0; i < 15; i++)
            [self.numbers addObject:[NSNumber numberWithInt:i+1]];
        [self.numbers addObject:[NSNumber numberWithInt:0]];
    }
    return self;
}

-(void)scramble:(int)n{
    int row = 0, col = 0;
    int choice;
    for(row = 0; row < 4; row++){
        for(col = 0; col < 4; col++)
            if([[self.numbers objectAtIndex:col+4*row] intValue] == 0) break;
        if([[self.numbers objectAtIndex:col+4*row] intValue] == 0) break;
    }
    
    for(int i = 0; i < n; i++){
        choice = arc4random()%4;
        if(choice == 0 && [self canSlideTileUpAtRow:row+1 Column:col]){
            [self slideTileAtRow:row+1 Column:col];
            row++;
        }else if(choice == 1 && [self canSlideTileDownAtRow:row-1 Column:col]){
            [self slideTileAtRow:row-1 Column:col];
            row--;
        }else if(choice == 2 && [self canSlideTileLeftAtRow:row Column:col+1]){
            [self slideTileAtRow:row Column:col+1];
            col++;
        }else if(choice == 3 && [self canSlideTileRightAtRow:row Column:col-1]){
            [self slideTileAtRow:row Column:col-1];
            col--;
        }else{
            i--;
        }
    }
}

-(int)getTileAtRow:(int)row Column:(int)col{
    return [[self.numbers objectAtIndex:col+row*4] intValue];
}

-(void)getRow:(int*)row Column:(int*)col ForTile:(int)tile{
    for(int r = 0; r < 4; r++){
        for(int c = 0; c < 4; c++){
            if([[self.numbers objectAtIndex:c+r*4] intValue] == tile){
                *row = r;
                *col = c;
                return;
            }
        }
    }
}

-(BOOL)isSolved{
    for(int i = 0; i < 15; i++)
        if([[self.numbers objectAtIndex:i] intValue] != i+1) return false;
    return true;
}

-(BOOL)canSlideTileUpAtRow:(int)row Column:(int)col{
    if(row < 1 || row > 3) return false;
    if([[self.numbers objectAtIndex:col+4*(row-1)] intValue] == 0) return true;
    return false;
}

-(BOOL)canSlideTileDownAtRow:(int)row Column:(int)col{
    if(row < 0 || row > 2) return false;
    if([[self.numbers objectAtIndex:col+4*(row+1)] intValue] == 0) return true;
    return false;
}

-(BOOL)canSlideTileLeftAtRow:(int)row Column:(int)col{
    if(col < 1 || col > 3) return false;
    if([[self.numbers objectAtIndex:(col-1)+4*row] intValue] == 0) return true;
    return false;
}

-(BOOL)canSlideTileRightAtRow:(int)row Column:(int)col{
    if(col < 0 || col > 2) return false;
    if([[self.numbers objectAtIndex:(col+1)+4*row] intValue] == 0) return true;
    return false;
}

-(void)slideTileAtRow:(int)row Column:(int)col{
    if([self canSlideTileUpAtRow:row Column:col]){
        [self.numbers replaceObjectAtIndex:col+(row-1)*4 withObject:[self.numbers objectAtIndex:col+row*4]];
        [self.numbers replaceObjectAtIndex:col+row*4 withObject:[NSNumber numberWithInt:0]];
    }
    else if([self canSlideTileDownAtRow:row Column:col]){
        [self.numbers replaceObjectAtIndex:col+(row+1)*4 withObject:[self.numbers objectAtIndex:col+row*4]];
        [self.numbers replaceObjectAtIndex:col+row*4 withObject:[NSNumber numberWithInt:0]];
    }
    else if([self canSlideTileLeftAtRow:row Column:col]){
        [self.numbers replaceObjectAtIndex:(col-1)+row*4 withObject:[self.numbers objectAtIndex:col+row*4]];
        [self.numbers replaceObjectAtIndex:col+row*4 withObject:[NSNumber numberWithInt:0]];
    }
    else if([self canSlideTileRightAtRow:row Column:col]){
        [self.numbers replaceObjectAtIndex:(col+1)+row*4 withObject:[self.numbers objectAtIndex:col+row*4]];
        [self.numbers replaceObjectAtIndex:col+row*4 withObject:[NSNumber numberWithInt:0]];
    }
}

@end
