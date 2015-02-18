//
//  ViewController.m
//  15puzzle
//
//  Created by Adam Matthew Bennett on 2/11/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "ViewController.h"
#import "FifteenBoardView.h"
#import "AppDelegate.h"
#import "FifteenBoard.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet FifteenBoardView *boardView;

@end

@implementation ViewController

-(NSString*)sandBoxFileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = paths[0];
    NSString *fileName = [docDir stringByAppendingPathComponent:@"gameboard.plist"];
    return fileName;
}

- (void) appWillResignActive:(NSNotification *)notification{
    NSLog(@"appWillResignActive:");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)tileSelected:(UIButton*)sender{
    NSLog(@"tileSelected: %d", (int) sender.tag);
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FifteenBoard *board = appDelegate.board;

    int row, col;
    [board getRow:&row Column:&col ForTile:(int)sender.tag];
    const CGRect buttonBounds = sender.bounds;
    CGPoint buttonCenter = sender.center;
    BOOL slide = false;
    if([board canSlideTileUpAtRow:row Column:col]){
        slide = true;
        buttonCenter.y -= buttonBounds.size.height;
    }else if([board canSlideTileDownAtRow:row Column:col]){
        slide = true;
        buttonCenter.y += buttonBounds.size.height;
    }else if([board canSlideTileRightAtRow:row Column:col]){
        slide = true;
        buttonCenter.x += buttonBounds.size.width;
    }else if([board canSlideTileLeftAtRow:row Column:col]){
        slide = true;
        buttonCenter.x -= buttonBounds.size.width;
    }
    
    if(slide){
        [board slideTileAtRow:row Column:col];
        [UIView animateWithDuration:0.5 animations:^{sender.center = buttonCenter;}];
        if([board isSolved]) NSLog(@"You Win");
    }
}

-(IBAction)shuffleTiles:(id)sender{
    NSLog(@"shuffleTiles:");
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FifteenBoard *board = appDelegate.board;
    [board scramble:150];
    [self.boardView setNeedsLayout];
}

@end
