//
//  DetalViewController.h
//  Homepwner
//
//  Created by Admin on 1/14/14.
//  Copyright (c) 2014 slayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateViewController.h"

@class BNRItem;

@interface DetalViewController : UIViewController
{

    __weak IBOutlet UITextField *nameField;

    __weak IBOutlet UITextField *serialNumberField;

    __weak IBOutlet UITextField *valueField;
    
    
    __weak IBOutlet UILabel *dateLabel;
}

- (IBAction)changeDate:(id)sender;

@property (nonatomic, strong) BNRItem *item;

@end
