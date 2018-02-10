//
//  OrderDeskInfo.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-4.
//  Copyright 2011年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import <Foundation/Foundation.h>

@interface OrderBookDeskInfo : NSObject
@property NSString *orderBookId;
@property NSString *orderBookDeskId;
@property NSDate *bookBeginDate;
@property NSDate *bookEndDate;
@property NSString *comment;
@property NSDate *createDate;
@property NSString *customer;
@property NSString *linkPhone;
@property NSNumber *quantity;
@property NSString *fullName;
@property NSString *deskId;
@property NSString *deskNo;
@property NSString *userId;
@property NSString *userName;
- (id)initWithDictionary:(NSDictionary*)dict;
@end
