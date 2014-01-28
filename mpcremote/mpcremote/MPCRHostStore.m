//
//  MPCRHostStore.m
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRHostStore.h"
#import "MPCRHost.h"

@implementation MPCRHostStore

+ (MPCRHostStore *)sharedStore
{
    static MPCRHostStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self){
        allHosts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allHosts{
    return allHosts;
}

- (MPCRHost *)createDefaultHost
{
    MPCRHost *host = [MPCRHost defaultHost];
    [allHosts addObject:host];
    return host;
}

- (void)addHost:(MPCRHost *)host
{
    [allHosts addObject:host];
}

- (void)removeHost:(MPCRHost *)host
{
    [allHosts removeObjectIdenticalTo:host];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    MPCRHost *host = [allHosts objectAtIndex:from];
    [allHosts removeObjectAtIndex:from];
    [allHosts insertObject:host atIndex:to];
}



@end
