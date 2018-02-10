//
//  OrderInfo.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-19.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDeskInfo.h"
@interface OrderInfo : NSObject
@property OrderDeskInfo *orderDesk;
@property NSMutableArray *lOrderMenu;
@property NSMutableArray *lLackMenu;
@property NSMutableArray *lPackage;
@end
