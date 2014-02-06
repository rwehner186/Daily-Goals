//
//  DetailViewController.m
//  DailyGoals
//
//  Created by Ross Wehner on 2/5/14.
//  Copyright (c) 2014 Ross Wehner. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh"];
    NSString *resultStringHour = [dateFormatter stringFromDate: currentTime];
    [dateFormatter setDateFormat:@"a"];
    NSString *resultStringAMPM = [dateFormatter stringFromDate: currentTime];
   
    // sets background to be blue between 2 AM and 10 AM, Red between 10AM and 6PM, and Purple between 6PM and 2am
    if ([resultStringHour intValue] >= 2 && [resultStringHour intValue] <= 9 && [resultStringAMPM isEqualToString: @"AM"])
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"morningBG.png"]];
    }
    else if(([resultStringHour intValue] >= 10 && [resultStringAMPM isEqualToString: @"PM"]) || ([resultStringHour intValue] <= 5 && [resultStringAMPM isEqualToString: @"PM"]))
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dayBG.png"]];
    }
    else if(([resultStringHour intValue] >= 6 && [resultStringAMPM isEqualToString: @"PM"]) || ([resultStringHour intValue] <= 1 && [resultStringAMPM isEqualToString: @"AM"]) || ([resultStringHour intValue] == 12 && [resultStringAMPM isEqualToString: @"AM"]))
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nightBg.png"]];
    }
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
