//
//  AppDelegate.h
//  15puzzle
//
//  Created by Adam Matthew Bennett on 2/11/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FifteenBoard.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FifteenBoard *board;

@end

