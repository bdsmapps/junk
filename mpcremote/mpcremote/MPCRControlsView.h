//
//  MPCRControlsView.h
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPCRHost;

@interface MPCRControlsView : UIViewController
{
}

@property (nonatomic, strong) MPCRHost *host;

- (IBAction)remoteCommand:(id)sender;

@end
