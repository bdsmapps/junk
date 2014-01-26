//
//  MPCRViewController.h
//  mpcremote
//
//  Created by Bohdan Likhyy on 1/25/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPCRViewController : UIViewController
{
    __weak IBOutlet UITextField *hostIP;
}


- (IBAction)testConnection:(id)sender;

@end
