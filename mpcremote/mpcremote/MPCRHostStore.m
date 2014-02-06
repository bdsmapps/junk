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
        [self loadFromFile];
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
    [self saveToFile];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    MPCRHost *host = [allHosts objectAtIndex:from];
    [allHosts removeObjectAtIndex:from];
    [allHosts insertObject:host atIndex:to];
    [self saveToFile];
}

- (void)loadFromFile
{
    NSString  *arrayPath;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        arrayPath = [[paths objectAtIndex:0]
                     stringByAppendingPathComponent:@"array.out"];
        NSArray *arrayFromFile = [NSArray arrayWithContentsOfFile:arrayPath];
        if ([arrayFromFile count] > 0){
            for (NSArray *host in arrayFromFile) {
                MPCRHost *h = [[MPCRHost alloc] initWithHostName:[host objectAtIndex:0]
                                                             hostIP:[host objectAtIndex:1]
                                                           hostPort:[host objectAtIndex:2]];
                [h setHostIPp1:[host objectAtIndex:3]];
                [h setHostIPp2:[host objectAtIndex:4]];
                [h setHostIPp3:[host objectAtIndex:5]];
                [h setHostIPp4:[host objectAtIndex:6]];
                [self addHost:h];

        }
    }
    
    }
}

- (void)saveToFile
{
    NSString  *arrayPath;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        // Path to save array data
        arrayPath = [[paths objectAtIndex:0]
                     stringByAppendingPathComponent:@"array.out"];
        NSMutableArray *arrToSave = [[NSMutableArray alloc] init];
        for (MPCRHost *host in allHosts) {
            [arrToSave addObject:[NSArray arrayWithObjects:host.hostName,
                                                           host.hostIPString,
                                                           host.hostPort,
                                                           host.hostIPp1,
                                                           host.hostIPp2,
                                                           host.hostIPp3,
                                                           host.hostIPp4,
                                                            nil]];
        }
        [arrToSave writeToFile:arrayPath atomically:YES];
        NSLog(@"saved");
        NSLog(@"%@", arrToSave);

    }

}


@end
