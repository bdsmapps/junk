//
//  MPCRControlsView.m
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRControlsView.h"
#import "MPCRHost.h"

@implementation MPCRControlsView
@synthesize host;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //NSString *currentVolume = [NSString stringWithFormat:@"%.0f", volume.value*100];
    [volumeLabel setText:[host currentVolume]];
    //NSLog(@"%@",[host currentVolume]);
}

- (IBAction)swipeHandler:(UISwipeGestureRecognizer *)sender{
    NSLog(@"SWIPE");
    [[self navigationController] popViewControllerAnimated:YES];
   
}


- (void)remoteCommand:(id)sender
{
    [host remoteCommand:[NSString stringWithFormat:@"%d", [sender tag]]];
    NSLog(@"command: %d", [sender tag]);
    NSLog(@"host: %@", [host hostIPString]);
}


- (IBAction)volumeChanged:(id)sender {
    NSLog(@"vol = %.2f", volume.value);
    NSString *currentVolume = [NSString stringWithFormat:@"%.0f", volume.value*100];
    [volumeLabel setText:currentVolume];
    [host volumeChangeToPercent:currentVolume];
}



@end
