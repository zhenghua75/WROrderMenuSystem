//
//  PackageInfo.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 12-4-10.
//  Copyright (c) 2012年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import <Foundation/Foundation.h>

@interface PackageInfo : NSObject
@property NSString *id;
@property NSString *packageId;
@property NSString *inventoryId;
@property NSString *code;
@property NSString *name;
@property NSDecimalNumber *salePrice;
@property NSString *optionalGroup;
@property NSNumber *isOptional;
@property NSString *comment;
- (id)initWithManagedObject:(NSManagedObject*)mo;
@end
