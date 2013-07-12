//
//  FATFlipsideViewController.h
//  PomoTimer
//
//  Created by Dan Dwire on 5/31/13.
//  Copyright (c) 2013 Dan Dwire. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FATFlipsideViewController;

@protocol FATFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FATFlipsideViewController *)controller;
@end

@interface FATFlipsideViewController : UIViewController

@property (weak, nonatomic) id <FATFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
