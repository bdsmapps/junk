//
//  MPCRHelpView.h
//  mpcremote
//
//  Created by Admin on 1/28/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPCRHelpView : UIViewController

{
}

@property (nonatomic, copy) void (^dismissBlock)(void);

- (IBAction)backgroundTapped:(id)sender;



@end
