//
//  FATFlipsideViewController.m
//  PomoTimer
//
//  Created by Dan Dwire on 5/31/13.
//  Copyright (c) 2013 Dan Dwire. All rights reserved.
//

#import "FATFlipsideViewController.h"

@interface FATFlipsideViewController ()

@end

@implementation FATFlipsideViewController

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
