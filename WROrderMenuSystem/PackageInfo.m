//
//  PackageInfo.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 12-4-10.
//  Copyright (c) 2012年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import "PackageInfo.h"
#import "NSManagedObject+Extends.h"
@implementation PackageInfo
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (id)initWithManagedObject:(NSManagedObject*)mo{
    self = [super init];
    if (self) {
        [self setId:[mo localId] ];
        [self setPackageId:[mo localPackageId]];
        [self setInventoryId:[mo localInventoryId]];
        [self setCode:[mo localCode]];
        [self setName:[mo localName]];
        [self setSalePrice:[mo localSalePrice]];
        [self setComment:[mo localComment]];
        [self setOptionalGroup:[mo localOptionalGroup]];
        [self setIsOptional:[mo localIsOptional]];
        [self setQuantity:[mo localQuantity]];
    }
    return self;
}
@end
