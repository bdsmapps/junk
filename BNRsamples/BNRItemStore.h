//
//  BNRItemstore.h
//  Homepwner
//
//  Created by Admin on 1/9/14.
//  Copyright (c) 2014 slayer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemstore : NSObject
{
    NSMutableArray *allItems;
}

+ (BNRItemstore *)sharedStore;

- (NSArray *)allItems;
- (BNRItem *)createItem;

@end
