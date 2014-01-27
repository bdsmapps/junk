//
//  MPCRViewController.h
//  mpcremote
//
//  Created by Bohdan Likhyy on 1/25/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCRHost.h"

@interface MPCRViewController : UIViewController
{
    __weak IBOutlet UITextField *hostIP;
    __weak IBOutlet UITextField *hostPort;
}


- (IBAction)testConnection:(id)sender;

@end
