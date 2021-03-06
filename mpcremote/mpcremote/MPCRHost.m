//
//  MPCRHost.m
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRHost.h"
#import "HTMLParser.h"
#import "HTMLNode.h"


@implementation MPCRHost
@synthesize hostName, hostIPString, hostPort, hostIPp1, hostIPp2, hostIPp3, hostIPp4;

+ (id)defaultHost
{
    MPCRHost *newHost = [[self alloc] initWithHostName:@"My PC"
                                                hostIP:@"0.0.0.0"
                                              hostPort:@"13579"];
    [newHost setHostIPp1:@"0"];
    [newHost setHostIPp2:@"0"];
    [newHost setHostIPp3:@"0"];
    [newHost setHostIPp4:@"0"];
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
    conn = nil;

}

- (void)volumeChangeToPercent:(NSString *)percent
{
    NSString *bodyData = [NSString stringWithFormat:@"wm_command=-2&volume=%@", percent];
    NSString *hostURL = [NSString stringWithFormat:@"http://%@:%@/command.html", hostIPString, hostPort];
    NSLog(@"body: %@", bodyData);
    NSLog(@"url: %@", hostURL);
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:hostURL]];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self];
    conn = nil;
}

- (NSString *)currentVolume
{
    NSString *hostURL = [NSString stringWithFormat:@"http://%@:%@/variables.html", hostIPString, hostPort];
    NSURL *url = [NSURL URLWithString:hostURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //parsing response for current volume
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:ret
                                                      error:&error];
    if (error) {
        NSLog(@"Error: %@", error);
        return nil;
    }
    
    HTMLNode *bodyNode = [parser body];
    NSArray *inputNodes = [bodyNode findChildTags:@"p"];
    
    //create string with current volume if parsing succeeded
    NSString *currentVolume = [[NSString alloc] init];
    for (HTMLNode *inputNode in inputNodes) {
        if ([[inputNode getAttributeNamed:@"id"] isEqualToString:@"volumelevel"]) {
            currentVolume = [inputNode contents];
            break;
        } else {
            currentVolume = nil;
        }
    }

    //return current volume or default value
    NSLog(@"return vol: %@", currentVolume);
    return currentVolume;
}


@end
