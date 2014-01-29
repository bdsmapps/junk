//
//  MPCRHelpView.m
//  mpcremote
//
//  Created by Admin on 1/28/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRHelpView.h"
#import "MPCRHostPickerViewController.h"

@implementation MPCRHelpView
@synthesize dismissBlock;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self setTitle:@"Help"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}


- (IBAction)backgroundTapped:(id)sender {
    NSLog(@"tap");
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}




@end
