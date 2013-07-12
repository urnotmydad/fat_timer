//
//  FATAppDelegate.h
//  PomoTimer
//
//  Created by Dan Dwire on 5/31/13.
//  Copyright (c) 2013 Dan Dwire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FATMainViewController.h"

@interface FATAppDelegate : UIResponder <UIApplicationDelegate>
{
    FATMainViewController *fatViewController;
    NSDate *alarmEndTime;
    
}

@property (strong, nonatomic) UIWindow *window;

@end
