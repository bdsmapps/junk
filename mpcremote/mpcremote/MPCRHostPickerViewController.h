//
//  MPCRHostPickerViewController.h
//  mpcremote
//
//  Created by Admin on 1/28/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCRHostViewController.h"

@interface MPCRHostPickerViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

- (IBAction)addHost:(id)sender;

@end

