//
//  MPCRControlsView.m
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRControlsView.h"
#import "MPCRHost.h"
#import "MPCRHostViewController.h"
#import "MPCRHostStore.h"
#import "MPCRHostPickerViewController.h"

@implementation MPCRControlsView
@synthesize host;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    //load gesture recognizer to handle "back" swipe
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:gestureRecognizer];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //hide navigation bar
    self.navigationController.navigationBarHidden = YES;
    
    //disable all controls until connection will be established
    [self disableControls];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //start spinner
    [loadIndicator setHidden:NO];
    [loadIndicator startAnimating];
    //showing help
    [volumeLabel setText:@"Connecting to the host..."];
    
    //connect to host in background
    dispatch_async(dispatch_get_main_queue(), ^{
        [self establishConnection];
    });
}


//method to handle "back" swipe, will dismiss current view and back to host picker
- (IBAction)swipeHandler:(UISwipeGestureRecognizer *)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}


//request to host with specific command from sender tag
- (void)remoteCommand:(id)sender
{
    [host remoteCommand:[NSString stringWithFormat:@"%d", [sender tag]]];
    NSLog(@"command: %d", [sender tag]);
    NSLog(@"host: %@", [host hostIPString]);
}


//request to host with volume info
- (IBAction)volumeChanged:(id)sender {
    NSLog(@"vol = %.2f", volume.value);
    NSString *currentVolume = [NSString stringWithFormat:@"%.0f", volume.value*100];
    NSString *volumeToShow = [NSString stringWithFormat:@"Volume: %@ %%", currentVolume];
    [volumeLabel setText:volumeToShow];
    [host volumeChangeToPercent:currentVolume];
}


- (void)disableControls
{
    [volume setUserInteractionEnabled:NO];
    [pauseButton setUserInteractionEnabled:NO];
    [playButton setUserInteractionEnabled:NO];
}


- (void)enableControls
{
    [volume setUserInteractionEnabled:YES];
    [pauseButton setUserInteractionEnabled:YES];
    [playButton setUserInteractionEnabled:YES];
}


//alert for connection problems
- (void)showAlertMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection problems:"
                                                    message:@"Make sure that MPC is running"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Try again", nil];
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //action for try button
    if (buttonIndex == 1) {
        //start spinner
        [loadIndicator setHidden:NO];
        [loadIndicator startAnimating];
        //showing help
        [volumeLabel setText:@"Connecting to the host..."];
        
        //connect to host in background
        dispatch_async(dispatch_get_main_queue(), ^{
            [self establishConnection];
        });
    }
    
    //action for cancel button
    if (buttonIndex == 0) {
        //show host picker controller
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}



- (void)establishConnection
{
    [self disableControls];
    
    NSString *currentVolume = [host currentVolume];
    if (!currentVolume) {
        [self showAlertMessage];
        [volumeLabel setText:@"Volume:"];
    } else {
        NSString *volumeToShow = [NSString stringWithFormat:@"Volume: %@ %%", currentVolume];
        [volumeLabel setText:volumeToShow];
        [volume setValue:currentVolume.floatValue / 100.0];
    }
    
    //stop spinner
    [loadIndicator stopAnimating];
    [loadIndicator setHidden:YES];
    
    [self enableControls];
}



@end
