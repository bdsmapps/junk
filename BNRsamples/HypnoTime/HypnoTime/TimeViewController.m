//
//  TimeViewController.m
//  HypnoTime
//
//  Created by Admin on 12/24/13.
//  Copyright (c) 2013 slayer. All rights reserved.
//

#import "TimeViewController.h"

@implementation TimeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Time"];
    }
    return self;
    
}

- (IBAction)showCurrentTime:(id)sender {

    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    [timeLabel setText:[formatter stringFromDate:now]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"time loaded");
    //[[self view] setBackgroundColor:[UIColor greenColor]];
}

- (void)viewWillAppear:(BOOL)animated {

    NSLog(@"time will appear");
    [super viewWillAppear:animated];
    [self showCurrentTime:nil];
}


@end
