//
//  OrderDeskInfo.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-4.
//  Copyright 2011年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import "OrderBookDeskInfo.h"
#import "NSDictionary+Extends.h"
@implementation OrderBookDeskInfo
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        [self setOrderBookId:[dict remoteOrderBookId]];
        [self setOrderBookDeskId:[dict remoteOrderBookDeskId]];
        [self setBookBeginDate:[dict remoteBookBeginDate]];
        [self setBookEndDate:[dict remoteBookEndDate]];
        [self setComment:[dict remoteComment]];
        [self setCreateDate:[dict remoteCreateDate]];
        [self setCustomer:[dict remoteCustomer]];
        [self setLinkPhone:[dict remoteLinkPhone]];
        [self setQuantity:[dict remoteQuantity]];
        [self setUserId:[dict remoteUserId]];
        [self setUserName:[dict remoteUserName]];
        [self setFullName:[dict remoteFullName]];
        [self setDeskNo:[dict remoteDeskNo]];
        [self setDeskId:[dict remoteDeskId]];
    }
    return self;
}
@end
