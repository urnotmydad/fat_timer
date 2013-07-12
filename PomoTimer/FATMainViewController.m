//
//  FATMainViewController.m
//  PomoTimer
//
//  Created by Dan Dwire on 5/31/13.
//  Copyright (c) 2013 Dan Dwire. All rights reserved.
//

#import "FATMainViewController.h"

@interface FATMainViewController ()

@end

@implementation FATMainViewController

int hours, minutes, seconds;
int secondsLeft;
int timerMode;
int timerTimes[] = {1500, 300, 600};
bool timerRunning;

@synthesize timerText;
@synthesize soundFileObject;
@synthesize soundFileURLRef;
@synthesize alarmEndDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    timerMode = WORK_MODE;
    timerRunning = NO;
    secondsLeft = timerTimes[timerMode];
    [self updateCounter];
    
    // Create the URL for the source audio file. The URLForResource:withExtension: method is
    //    new in iOS 4.0.
    NSURL *ringSound   = [[NSBundle mainBundle] URLForResource: @"ring"
                                                withExtension: @"aif"];
    
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (__bridge CFURLRef) ringSound;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
                                      soundFileURLRef,
                                      &soundFileObject
                                      );

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FATFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (IBAction) startTimerButton: (id)sender
{
    if (secondsLeft <=0) {
        secondsLeft = timerTimes[timerMode];
    }
    [self startTimer:secondsLeft];
}
- (IBAction) stopTimerButton: (id)sender
{
    [self stopTimer];
}
- (IBAction) segControllPress:(id)sender {
    if (segControl.selectedSegmentIndex != timerMode) {
        
        switch (segControl.selectedSegmentIndex) {
            case SHORT_MODE:
                navItem.title = @"Short Break";
                timerMode = SHORT_MODE;
                break;
            case LONG_MODE:
                navItem.title = @"Long Break";
                timerMode = LONG_MODE;
                break;
            default:
                navItem.title = @"Work Block";
                timerMode = WORK_MODE;
                break;
        }
        [self resetTimer];
        [self startTimer:timerTimes[timerMode]];
    }
}
- (IBAction) resetButton:(id)sender
{
    [self resetTimer];
}
- (void) resetTimer {
    [self stopTimer];
    secondsLeft = timerTimes[timerMode];
    [self updateCounter];
}
- (void) startTimer: (int) seconds
{
    [self stopTimer];
    secondsLeft = seconds;
    // calc new end date
    self.alarmEndDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    
    [self updateCounter];
    timerRunning = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    
    UILocalNotification *localNotif = [UILocalNotification new];
    
    if (localNotif == nil) {
        return;
    }
    localNotif.fireDate = self.alarmEndDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    // Notification details
    localNotif.alertBody = @"Timer is up!";
	// Set the action button
    localNotif.alertAction = @"View";
    
    localNotif.soundName = @"ring.aif";
    
    // Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"dateHere" forKey:@"alarmEndDate"];
    localNotif.userInfo = infoDict;
   
     // Clear out the old notification before scheduling a new one.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
}

- (void) stopTimer
{
    [timer invalidate];
    timerRunning = NO;
    
    // cancel notification
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void) resumeTimer
{
    
}

- (void) updateCounter
{
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft %3600) % 60;
    self.timerText = [NSString stringWithFormat:@"%02d:%02d" , minutes, seconds];
    counterLabel.text = self.timerText;
}

-(void) updateTimer: (NSTimer *)aTimer
{
    if (secondsLeft > 0 ){
        secondsLeft -- ;
    }
    else {
        secondsLeft = hours = minutes = seconds = 0;
        [self stopTimer];
        [self soundAlarm];
    }
    [self updateCounter];
}

- (void) soundAlarm
{
    AudioServicesPlayAlertSound (soundFileObject);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}



@end
