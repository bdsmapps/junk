//
//  MPCRHostViewController.h
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPCRHost;

@interface MPCRHostViewController : UIViewController <UINavigationControllerDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UITextField *hostName;
    __weak IBOutlet UITextField *hostIPp1;
    __weak IBOutlet UITextField *hostIPp2;
    __weak IBOutlet UITextField *hostIPp3;
    __weak IBOutlet UITextField *hostIPp4;
    __weak IBOutlet UITextField *hostPort;
    
}

- (id)initForNewHost:(BOOL)isNew;
- (IBAction)callHelpPage:(id)sender;
- (IBAction)backgroundTapped:(id)sender;

@property (nonatomic, strong) MPCRHost *host;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
