//
//  MPCRControlsView.m
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRControlsView.h"
#import "MPCRHost.h"

@implementation MPCRControlsView
@synthesize host;


- (void)remoteCommand:(id)sender
{
    [host remoteCommand:[NSString stringWithFormat:@"%d", [sender tag]]];
    NSLog(@"command: %d", [sender tag]);
    NSLog(@"host: %@", [host hostIPString]);
}

@end
