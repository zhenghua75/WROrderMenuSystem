//
//  DeskInfo.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-2.
//  Copyright 2011年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import <Foundation/Foundation.h>
typedef enum{
    Opened = 0,
    Checkouted = 1,
    Canceled = 2,
    Ordered = 3
}OrderDishStatus;
//NSString * const OrderDishStatusDescription[4];
//NSString * const OrderDishImageFileName[4];
static NSString * const OrderDishStatusDescription[4] = { @"已开台", @"已结账", @"已撤销", @"已下单"};
static NSString * const OrderDishImageFileName[4]={@"desk-red.png",@"desk-white.png",@"desk-white.png",@"desk-green.png"};
@interface OrderDeskInfo : NSObject
@property NSString *orderDishId;
@property NSString *orderDeskId;
@property NSString *deskNo;
@property NSString *deskId;
@property NSString *userId;
@property NSNumber *status;
@property NSString *userName;
@property NSString *fullName;
@property NSDate *createDate;

- (id)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*)toDictionary;
- (NSString*)getStatusName;
- (NSString*)getImageFileName;
@end
