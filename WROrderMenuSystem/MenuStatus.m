//
//  MenuStatus.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-30.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import "MenuStatus.h"
#import "NSDictionary+Extends.h"
@implementation MenuStatus
- (id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        [self setId:[dict remoteId]];
        [self setInventory:[dict remoteInventory]];
        [self setStatus:[dict remoteStatus]];
    }
    return self;
}
@end
