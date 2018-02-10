//
//  DeskInfo.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-2.
//  Copyright 2011年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import "OrderDeskInfo.h"
#import "NSDictionary+Extends.h"

@implementation OrderDeskInfo
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (NSString*)getStatusName{
    if (_status==nil) {
        return @"未开台";
    }
    return OrderDishStatusDescription[[_status intValue]];
}
- (NSString*)getImageFileName{
    if (_status==nil) {
        return @"desk-white.png";
    }
    return OrderDishImageFileName[[_status intValue]];
}
- (id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        [self setOrderDishId:[dict remoteOrderDishId]];
        [self setOrderDeskId:[dict remoteOrderDeskId]];
        [self setDeskId:[dict remoteDeskId]];
        [self setDeskNo:[dict remoteDeskNo]];
        [self setUserId:[dict remoteUserId]];
        [self setStatus:[dict remoteStatus]];
        [self setCreateDate:[dict remoteCreateDate]];
        [self setUserName:[dict remoteUserName]];
        [self setFullName:[dict remoteFullName]];
    }
    return self;
}
- (NSDictionary*)toDictionary{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:_orderDishId forKey:@"OrderDishId"];
    [dict setValue:_orderDeskId forKey:@"OrderDeskId"];
    [dict setValue:_deskId forKey:@"DeskId"];
    [dict setValue:_deskNo forKey:@"DeskNo"];
    [dict setValue:_userId forKey:@"UserId"];
    [dict setValue:_status forKey:@"Status"];
    [dict setValue:_createDate forKey:@"CreateDate"];
    [dict setValue:_userName forKey:@"UserName"];
    [dict setValue:_fullName forKey:@"FullName"];
    return dict;
}
@end
