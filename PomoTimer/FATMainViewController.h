//
//  FATMainViewController.h
//  PomoTimer
//
//  Created by Dan Dwire on 5/31/13.
//  Copyright (c) 2013 Dan Dwire. All rights reserved.
//

#import "FATFlipsideViewController.h"
#import "FATTimer.h"
#include <AudioToolbox/AudioToolbox.h>

#define WORK_MODE 0
#define SHORT_MODE 1
#define LONG_MODE 2

@interface FATMainViewController : UIViewController <FATFlipsideViewControllerDelegate, UIPopoverControllerDelegate> {
    
    IBOutlet UILabel *counterLabel;
    IBOutlet UISegmentedControl *segControl;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UINavigationItem *navItem;
    
    FATTimer * fatTimer;
    
    NSTimer *timer;
    float resumeTime;
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
}


- (IBAction) startTimerButton: (id) sender;
- (IBAction) stopTimerButton: (id) sender;
- (IBAction) segControllPress: (id) sender;
- (IBAction) resetButton:(id)sender;

- (void) startTimer: (int) seconds;
- (void) resumeTimer;
- (void) stopTimer;
- (void) resetTimer;
- (void) updateCounter;
- (void) updateTimer:(NSTimer*)timer;
- (void) soundAlarm;

@property NSString *timerText;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property NSDate *alarmEndDate;

@end
