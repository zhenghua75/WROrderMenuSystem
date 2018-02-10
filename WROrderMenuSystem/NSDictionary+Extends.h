//
//  NSDictionary+InventoryCategory.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-13.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(Extends)
- (NSString*)remoteId;
- (NSString*)remoteCode;
- (NSString*)remoteName;
- (NSString*)remoteComment;

//////////////////
- (NSString*)remoteCategory;
- (NSString*)remoteEnglishName;
- (NSString*)remoteUnitOfMeasure;
- (NSString*)remoteSpecs;
- (NSString*)remoteImageFileName;
- (NSDecimalNumber*)remoteSalePoint;
- (NSDecimalNumber*)remoteSalePoint0;
- (NSDecimalNumber*)remoteSalePoint1;
- (NSDecimalNumber*)remoteSalePoint2;
- (NSDecimalNumber*)remoteSalePrice;
- (NSDecimalNumber*)remoteSalePrice0;
- (NSDecimalNumber*)remoteSalePrice1;
- (NSDecimalNumber*)remoteSalePrice2;
- (NSNumber*)remoteIsDonate;
- (NSNumber*)remoteIsRecommend;
- (NSNumber*)remoteIsPackage;
- (NSNumber*)remoteStars;
- (NSNumber*)remoteSort;
- (NSString*)remoteFeature;
- (NSString*)remoteDosage;
- (NSString*)remotePalette;
- (NSString*)remoteEnglishIntroduce;
- (NSString*)remoteEnglishDosage;
/////////
- (NSString*)remotePackageId;
- (NSString*)remoteInventoryId;
- (NSNumber*)remoteIsOptional;
- (NSString*)remoteOptionalGroup;
/////////////////////////
- (NSString*)remoteFileName;
- (NSDate*)remoteModifyDate;
///////////////////
- (NSString*)remoteOrderDishId;
- (NSString*)remoteOrderDeskId;
- (NSString*)remoteDeskNo;
- (NSString*)remoteDeskId;
- (NSString*)remoteUserId;
- (NSNumber*)remoteStatus;
//- (NSString*)statusName;
//////////////////////
- (NSString*)remoteOrderBookId;
- (NSString*)remoteOrderBookDeskId;
- (NSDate*)remoteBookBeginDate;
- (NSDate*)remoteBookEndDate;
- (NSDate*)remoteCreateDate;
- (NSString*)remoteCustomer;
- (NSString*)remoteLinkPhone;
- (NSDecimalNumber*)remoteQuantity;
- (NSString*)remoteFullName;
//- (NSString*)DeptName;
///////////////////
- (NSString*)remoteUserName;
////////////////////
- (NSString*)remoteOrderMenuId;
- (NSString*)remoteInvId;
- (NSString*)remoteInvCode;
- (NSString*)remoteInvName;
//- (NSDecimalNumber*)Price;
- (NSDecimalNumber*)remoteAmount;
- (NSNumber*)remotePackageSn;
//////////////////////
- (NSDictionary*)remoteOrderDesk;
- (NSArray*)remotelOrderMenu;
- (NSNumber*)remoteIsAdd;
- (NSNumber*)remoteIsDelete;
- (NSString*)remoteInventory;
- (NSArray*)remotelLackMenu;

- (id)objectForKeyReturnNil:(id)key;
- (NSDate *)getJSONDate:(NSString*)jsonDateString;
- (NSString*)getStr:(NSString*)key;
- (NSNumber*)getBool:(NSString*)key;
- (NSNumber*)getInt:(NSString*)key;
- (NSDecimalNumber*)getDec:(NSString*)key;
- (NSArray*)getArray:(NSString*)key;
- (NSDictionary*)getDict:(NSString*)key;
@end
