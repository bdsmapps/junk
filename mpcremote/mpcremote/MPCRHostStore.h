//
//  MPCRHostStore.h
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MPCRHost;

@interface MPCRHostStore : NSObject
{
    NSMutableArray *allHosts;
}

+ (MPCRHostStore *)sharedStore;
- (NSArray *)allHosts;
- (MPCRHost *)createDefaultHost;
- (void)addHost:(MPCRHost *)host;
- (void)removeHost:(MPCRHost *)host;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;


@end
