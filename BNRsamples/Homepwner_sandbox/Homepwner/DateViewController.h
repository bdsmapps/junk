//
//  DateViewController.h
//  Homepwner
//
//  Created by Admin on 1/15/14.
//  Copyright (c) 2014 slayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DateViewController : UIViewController
{
    __weak IBOutlet UIDatePicker *pickedDate;
}

@property (nonatomic, strong) BNRItem *item;

@end
