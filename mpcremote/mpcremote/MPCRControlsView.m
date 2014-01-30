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
    [loadIndicator setHidden:NO];
    [loadIndicator startAnimating];
    [self disableControls];
}

- (IBAction)swipeHandler:(UISwipeGestureRecognizer *)sender{
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /*NSString *currentVolume = [host currentVolume];
    if (!currentVolume) {
        [self showAlertMessage];

    } else {
    
        [volumeLabel setText:currentVolume];
        [volume setValue:currentVolume.floatValue / 100.0];
    }*/
    [self establishConnection];
    
    
    
    
    [loadIndicator stopAnimating];
    [loadIndicator setHidden:YES];
    
    
    
    
    
    [self enableControls];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        MPCRHostViewController *hostController = [[MPCRHostViewController alloc] initForNewHost:NO];
        
        [hostController setHost: [self host]];
        [[self navigationController] pushViewController:hostController animated:YES];
    }
    if (buttonIndex == 1) {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        [self establishConnection];
    
    }
}

- (void)showAlertMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection problems"
                                                    message:@"Please edit configs or try again"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Edit configs", @"Try again", nil];
    [alert show];
    
}

- (void)establishConnection
{
    //[loadIndicator setHidden:NO];
    //[loadIndicator startAnimating];
    [self disableControls];
    NSString *currentVolume = [host currentVolume];
    //currentVolume = nil;
    if (!currentVolume) {
        [self showAlertMessage];
    } else {
        [volumeLabel setText:currentVolume];
        [volume setValue:currentVolume.floatValue / 100.0];
    }
    

}



@end
