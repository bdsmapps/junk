//
//  DetalViewController.m
//  Homepwner
//
//  Created by Admin on 1/14/14.
//  Copyright (c) 2014 slayer. All rights reserved.
//

#import "DetalViewController.h"
#import "BNRItem.h"

/*@interface DetalViewController ()

@end*/

@implementation DetalViewController

@synthesize item;

- (void)setItem:(BNRItem *)i
{
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}

- (void)changeDate:(id)sender
{
    DateViewController *dateViewController = [[DateViewController alloc] init];
    [dateViewController setItem:item];
    [[self navigationController] pushViewController:dateViewController animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [nameField setText:[item itemName]];
    [serialNumberField setText:[item serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d", [item valueInDollars]]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]];
    //[[self navigationItem] setTitle:[item itemName]];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self view] endEditing:YES];
    [item setItemName:[nameField text]];
    [item setSerialNumber:[serialNumberField text]];
    [item setValueInDollars:[[valueField text] intValue]];
}



@end
