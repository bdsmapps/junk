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
@property (nonatomic, copy) NSString *hostIPp1;
@property (nonatomic, copy) NSString *hostIPp2;
@property (nonatomic, copy) NSString *hostIPp3;
@property (nonatomic, copy) NSString *hostIPp4;
@property (nonatomic, copy) NSString *hostIPString;
@property (nonatomic, copy) NSString *hostPort;

+ (id)defaultHost;
- (id)initWithHostName:(NSString *)name
                hostIP:(NSString *)ip
              hostPort:(NSString *)port;

- (void)remoteCommand:(NSString *)command;
- (void)volumeChangeToPercent:(NSString *)percent;
- (NSString *)currentVolume;


@end
