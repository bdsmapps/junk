//
//  MPCRHostViewController.m
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRHostViewController.h"
#import "MPCRHostStore.h"
#import "MPCRHost.h"
#import "MPCRHelpView.h"

@implementation MPCRHostViewController

@synthesize host, dismissBlock;

- (id)initForNewHost:(BOOL)isNew
{
    self = [super initWithNibName:@"MPCRHostViewController" bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:doneItem];
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    return self;
}

- (IBAction)callHelpPage:(id)sender {
    
    MPCRHelpView *helpView = [[MPCRHelpView alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:helpView];
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (void)save:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}


- (void)cancel:(id)sender
{
    [[MPCRHostStore sharedStore] removeHost:host];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initilizer" reason:@"Use initWithNewItem"  userInfo:nil];
    return nil;
}


- (void)setHost:(MPCRHost *)h
{
    host = h;
    [[self navigationItem] setTitle:[host hostName]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [hostName setText:[host hostName]];
    [hostPort setText:[host hostPort]];
    if ([host hostIPp1]) {
        [hostIPp1 setText:[host hostIPp1]];
    }
    if ([host hostIPp2]) {
        [hostIPp2 setText:[host hostIPp2]];
    }
    if ([host hostIPp3]) {
        [hostIPp3 setText:[host hostIPp3]];
    }
    if ([host hostIPp4]) {
        [hostIPp4 setText:[host hostIPp4]];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self view] endEditing:YES];
    NSString *ip = [NSString stringWithFormat:@"%d.%d.%d.%d", [hostIPp1 text].intValue, [hostIPp2 text].intValue, [hostIPp3 text].intValue, [hostIPp4 text].intValue];
    [host setHostIPString:ip];
    [host setHostIPp1:[hostIPp1 text]];
    [host setHostIPp2:[hostIPp2 text]];
    [host setHostIPp3:[hostIPp3 text]];
    [host setHostIPp4:[hostIPp4 text]];
    [host setHostPort:[hostPort text]];
    [host setHostName:[hostName text]];
    [[MPCRHostStore sharedStore] saveToFile];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int allowedLength;
    switch(textField.tag) {
        case 1:
            allowedLength = 3;      // triggered for input fields with tag = 1
            break;
        default:
            allowedLength = 255;   // length default when no tag (=0) value =255
            break;
    }
    
    if (textField.text.length >= allowedLength && range.length == 0) {
        return NO; // Change not allowed
    } else {
        return YES; // Change allowed
    }
}



@end
