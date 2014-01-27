//
//  MPCRHost.m
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRHost.h"

@implementation MPCRHost
@synthesize hostIPString, hostPort;

+ (id)defaultHost
{
    MPCRHost *newHost = [[self alloc] initWithHostName:@"My PC"
                                                hostIP:@""
                                              hostPort:@"13579"];
    return newHost;
}

- (id)initWithHostName:(NSString *)name
                hostIP:(NSString *)ip
              hostPort:(NSString *)port
{
    // Call the superclass's designated initializer
    self = [super init];
    
    // Did the superclass's designated initializer succeed?
    if(self) {
        // Give the instance variables initial values
        [self setHostName:name];
        [self setHostIPString:ip];
        [self setHostPort:port];
    }
    
    // Return the address of the newly initialized object
    return self;
}

- (id)init
{
    return [self initWithHostName:@"MPC host"
                           hostIP:@""
                         hostPort:@""];
}



- (void)remoteCommand:(NSString *)command
{
    NSString *bodyData = [NSString stringWithFormat:@"wm_command=%@", command];
    NSString *hostURL = [NSString stringWithFormat:@"http://%@:%@/command.html", hostIPString, hostPort];
    NSLog(@"body: %@", bodyData);
    NSLog(@"url: %@", hostURL);
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:hostURL]];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self];


}


@end
