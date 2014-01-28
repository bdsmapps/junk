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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTitle:@"Help"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (IBAction)dismissHelp:(id)sender {
    
    MPCRHostPickerViewController *hostPicker = [[MPCRHostPickerViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:hostPicker];
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navController animated:YES completion:nil];
}
@end
