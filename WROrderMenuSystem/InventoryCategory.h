//
//  Category.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-10.
//  Copyright 2011年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import <Foundation/Foundation.h>

@interface InventoryCategory : NSObject
@property NSString *id;
@property NSString *code;
@property NSString *name;
@property NSString *comment;
@property NSNumber *isDiscount;
@property NSNumber *categoryType;
@property NSNumber *deptType;
@property NSNumber *productType;
- (id)initWithManagedObject:(NSManagedObject*)mo;
@end
