//
//  MPCRHost.h
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPCRHost : NSObject

@property (nonatomic, copy) NSString *hostName;
@property (nonatomic) int hostIPp1;
@property (nonatomic) int hostIPp2;
@property (nonatomic) int hostIPp3;
@property (nonatomic) int hostIPp4;
@property (nonatomic, copy) NSString *hostIPString;
@property (nonatomic, copy) NSString *hostPort;

+ (id)defaultHost;
- (id)initWithHostName:(NSString *)name
                hostIP:(NSString *)ip
              hostPort:(NSString *)port;

- (void)remoteCommand:(NSString *)command;
- (void)volumeChangeToPercent:(NSString *)percent;
- (NSString *)currentVolume;
- (BOOL)isAvailable;


@end
