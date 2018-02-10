//
//  OrderInventory.h
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import <Foundation/Foundation.h>
typedef enum {
    Normal = 0,
    Withdraw = 1,
    Order = 2,
    Lack = 3,
    Hurry = 4,
    Make = 5,
    Out = 6,
    ReturnAfterOut = 7,
    Checkout = 8,
}OrderMenuStatus;
//NSString * const OrderMenuStatusDescription[9];
static NSString * const OrderMenuStatusDescription[9]={@"正常",@"退菜",@"下单",@"缺菜",@"催菜",@"制作",@"出菜",@"出菜后退菜",@"结账"};

@interface OrderMenuInfo : NSObject<NSCopying>
@property NSString *orderMenuId;
@property NSString *invId;
@property NSString *categoryId;
@property NSString *invCode;
@property NSString *invName;
@property NSString *englishName;
@property NSString *imageFileName;
@property NSString *imageFileName1;
@property NSString *imageFileName2;
@property NSDecimalNumber *salePrice;
@property NSDecimalNumber *quantity;
@property NSDecimalNumber *amount;
@property NSNumber *stars;
@property NSString *feature;
@property NSString *dosage;
@property NSString *palette;
@property UIImage *image;
@property UIImage *image1;
@property UIImage *image2;
//@property BOOL      IsConfirmed;
@property NSString *englishIntroduce;
@property NSString *englishDosage;
@property NSString *comment;
@property NSNumber *isAdd;
@property NSNumber *isDelete;
@property NSNumber *status;
//@property NSString *StatusName;
@property NSNumber *isPackage;
@property NSString *packageId;
@property NSNumber *packageSn;
@property NSNumber *isRecommend;

- (id)initWithManagedObject:(NSManagedObject*)mo;
- (id)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*)toDictionary;
@end
