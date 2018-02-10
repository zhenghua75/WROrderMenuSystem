//
//  NSManagedObject+Extends.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-20.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSManagedObject(Extends)
- (NSString*)localId;
- (NSString*)localCategory;
- (NSString*)localName;
- (NSDecimalNumber*)localSalePrice;
- (NSString*)localImageFileName;
- (NSNumber*)localStars;
- (NSString*)localFeature;
- (NSString*)localDosage;
- (NSString*)localPalette;
- (NSString*)localEnglishIntroduce;
- (NSString*)localEnglishDosage;
- (NSString*)localEnglishName;
- (NSNumber*)localIsPackage;
- (NSString*)localPackageId;
- (NSString*)localInventoryId;
- (NSString*)localCode;
- (NSString*)localComment;
- (NSString*)localOptionalGroup;
- (NSNumber*)localIsOptional;
- (NSNumber*)localIsRecommend;
//- (NSString*)packageId;

- (void)setLocalId:(NSDictionary*)dict;
- (void)setLocalCode:(NSDictionary*)dict;
- (void)setLocalName:(NSDictionary*)dict;
- (void)setLocalComment:(NSDictionary*)dict;
- (void)setLocalCategory:(NSDictionary*)dict;
- (void)setLocalEnglishName:(NSDictionary*)dict;
- (void)setLocalUnitOfMeasure:(NSDictionary*)dict;
- (void)setLocalSpecs:(NSDictionary*)dict;
- (void)setLocalImageFileName:(NSDictionary*)dict;
- (void)setLocalSalePoint:(NSDictionary*)dict;
- (void)setLocalSalePoint0:(NSDictionary*)dict;
- (void)setLocalSalePoint1:(NSDictionary*)dict;
- (void)setLocalSalePoint2:(NSDictionary*)dict;
- (void)setLocalSalePrice:(NSDictionary*)dict;
- (void)setLocalSalePrice0:(NSDictionary*)dict;
- (void)setLocalSalePrice1:(NSDictionary*)dict;
- (void)setLocalSalePrice2:(NSDictionary*)dict;
- (void)setLocalIsDonate:(NSDictionary*)dict;
- (void)setLocalIsRecommend:(NSDictionary*)dict;
- (void)setLocalIsPackage:(NSDictionary*)dict;
- (void)setLocalStars:(NSDictionary*)dict;
- (void)setLocalSort:(NSDictionary*)dict;
- (void)setLocalFeature:(NSDictionary*)dict;
- (void)setLocalDosage:(NSDictionary*)dict;
- (void)setLocalPalette:(NSDictionary*)dict;
- (void)setLocalEnglishIntroduce:(NSDictionary*)dict;
- (void)setLocalEnglishDosage:(NSDictionary*)dict;
- (void)setLocalPackageId:(NSDictionary*)dict;
- (void)setLocalInventoryId:(NSDictionary*)dict;
- (void)setLocalOptionalGroup:(NSDictionary*)dict;
- (void)setLocalIsOptional:(NSDictionary*)dict;
@end
