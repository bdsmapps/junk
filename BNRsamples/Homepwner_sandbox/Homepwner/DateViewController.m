//
//  DateViewController.m
//  Homepwner
//
//  Created by Admin on 1/15/14.
//  Copyright (c) 2014 slayer. All rights reserved.
//

#import "DateViewController.h"
#import "BNRItem.h"

@implementation DateViewController

@synthesize item;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [pickedDate setDate:[item dateCreated]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [item setDateCreated:[pickedDate date]];
   
}


@end
