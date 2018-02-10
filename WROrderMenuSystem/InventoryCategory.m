//
//  Category.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-10.
//  Copyright 2011年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import "InventoryCategory.h"
#import "NSManagedObject+Extends.h"
@implementation InventoryCategory
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
        [self setCode:[mo localCode]];
        [self setName:[mo localName]];
        [self setComment:[mo localComment]];
    }
    
    return self;
}
@end
