//
//  NSManagedObject+Extends.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-20.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import "NSManagedObject+Extends.h"
#import "NSDictionary+Extends.h"
@implementation NSManagedObject(Extends)
- (NSString*)localId{
    return [self valueForKey:@"id"];
}
- (NSString*)localCategory{
    return [self valueForKey:@"category"];
}
- (NSString*)localName{
    return [self valueForKey:@"name"];
}
- (NSDecimalNumber*)localSalePrice{
    return [self valueForKey:@"salePrice"];
}
- (NSString*)localImageFileName{
    return [self valueForKey:@"imageFileName"];
}
- (NSNumber*)localStars{
    return [self valueForKey:@"stars"];
}
- (NSNumber*)localFeature{
    return [self valueForKey:@"feature"];
}
- (NSString*)localDosage{
    return [self valueForKey:@"dosage"];
}
-(NSString*)localPalette{
    return [self valueForKey:@"palette"];
}
- (NSString*)localEnglishIntroduce{
    return [self valueForKey:@"englishIntroduce"];
}
- (NSString*)localEnglishDosage{
    return [self valueForKey:@"englishDosage"];
}
- (NSString*)localEnglishName{
    return [self valueForKey:@"englishName"];
}
- (NSNumber*)localIsPackage{
    return [self valueForKey:@"isPackage"];
}
- (NSString*)localPackageId{
    return [self valueForKey:@"packageId"];
}
- (NSString*)localInventoryId{
    return [self valueForKey:@"inventoryId"];
}
- (NSString*)localCode{
    return  [self valueForKey:@"code"];
}
- (NSString*)localComment{
    return [self valueForKey:@"comment"];
}
- (NSString*)localOptionalGroup{
    return [self valueForKey:@"optionalGroup"];
}
- (NSNumber*)localIsOptional{
    return [self valueForKey:@"isOptional"];
}
- (NSNumber*)localIsRecommend{
    return [self valueForKey:@"isRecommend"];
}

-(NSDecimalNumber*)localQuantity{
    return [self valueForKey:@"quantity"];
}
- (void)setLocalId:(NSDictionary*)dict{
    //NSString *strId = [[dict id] copy];
    [self setValue:[dict remoteId] forKey:@"id"];
    //strId=nil;
}
- (void)setLocalCode:(NSDictionary*)dict{
    [self setValue:[dict remoteCode] forKey:@"code"];
}
- (void)setLocalName:(NSDictionary*)dict{
    [self setValue:[dict remoteName] forKey:@"name"];
}
- (void)setLocalComment:(NSDictionary*)dict{
    [self setValue:[dict remoteComment] forKey:@"comment"];
}
- (void)setLocalCategory:(NSDictionary*)dict{
    [self setValue:[dict remoteCategory] forKey:@"category"];
}
- (void)setLocalEnglishName:(NSDictionary*)dict{
    [self setValue:[dict remoteEnglishName] forKey:@"englishName"];
}
- (void)setLocalUnitOfMeasure:(NSDictionary*)dict{
    [self setValue:[dict remoteUnitOfMeasure] forKey:@"unitOfMeasure"];
}
- (void)setLocalSpecs:(NSDictionary*)dict{
    [self setValue:[dict remoteSpecs] forKey:@"specs"];
}
- (void)setLocalImageFileName:(NSDictionary*)dict{
    [self setValue:[dict remoteImageFileName] forKey:@"imageFileName"];
}
- (void)setLocalSalePoint:(NSDictionary*)dict{
    [self setValue:[dict remoteSalePoint] forKey:@"salePoint"];
}
- (void)setLocalSalePoint0:(NSDictionary*)dict{
    [self setValue:[dict remoteSalePoint0] forKey:@"salePoint0"];
}
- (void)setLocalSalePoint1:(NSDictionary*)dict{
    [self setValue:[dict remoteSalePoint1] forKey:@"salePoint1"];
}
- (void)setLocalSalePoint2:(NSDictionary*)dict{
    [self setValue:[dict remoteSalePoint2] forKey:@"salePoint2"];
}
- (void)setLocalSalePrice:(NSDictionary*)dict{
    [self setValue:[dict remoteSalePrice] forKey:@"salePrice"];
}
- (void)setLocalSalePrice0:(NSDictionary*)dict{
    [self setValue:[dict remoteSalePrice0] forKey:@"salePrice0"];
}
- (void)setLocalSalePrice1:(NSDictionary*)dict{
    [self setValue:[dict remoteSalePrice1] forKey:@"salePrice1"];
}
- (void)setLocalSalePrice2:(NSDictionary*)dict{
    [self setValue:[dict remoteSalePrice2] forKey:@"salePrice2"];
}
- (void)setLocalIsDonate:(NSDictionary*)dict{
    [self setValue:[dict remoteIsDonate] forKey:@"isDonate"];
}
- (void)setLocalIsRecommend:(NSDictionary*)dict{
    [self setValue:[dict remoteIsRecommend] forKey:@"isRecommend"];
}
- (void)setLocalIsPackage:(NSDictionary*)dict{
    [self setValue:[dict remoteIsPackage] forKey:@"isPackage"];
}
- (void)setLocalStars:(NSDictionary*)dict{
    [self setValue:[dict remoteStars] forKey:@"stars"];
}
- (void)setLocalSort:(NSDictionary*)dict{
    [self setValue:[dict remoteSort] forKey:@"sort"];
}
- (void)setLocalFeature:(NSDictionary*)dict{
    [self setValue:[dict remoteFeature] forKey:@"feature"];
}
- (void)setLocalDosage:(NSDictionary*)dict{
    [self setValue:[dict remoteDosage] forKey:@"dosage"];
}
- (void)setLocalPalette:(NSDictionary*)dict{
    [self setValue:[dict remotePalette] forKey:@"palette"];
}
- (void)setLocalEnglishIntroduce:(NSDictionary*)dict{
    [self setValue:[dict remoteEnglishIntroduce] forKey:@"englishIntroduce"];
}
- (void)setLocalEnglishDosage:(NSDictionary*)dict{
    [self setValue:[dict remoteEnglishDosage] forKey:@"englishDosage"];
}
- (void)setLocalPackageId:(NSDictionary*)dict{
    [self setValue:[dict remotePackageId] forKey:@"packageId"];
}
- (void)setLocalInventoryId:(NSDictionary*)dict{
    [self setValue:[dict remoteInventoryId] forKey:@"inventoryId"];
}
- (void)setLocalOptionalGroup:(NSDictionary*)dict{
    [self setValue:[dict remoteOptionalGroup] forKey:@"optionalGroup"];
}
- (void)setLocalIsOptional:(NSDictionary*)dict{
    [self setValue:[dict remoteIsOptional] forKey:@"isOptional"];
}

- (void)setLocalQuantity:(NSDictionary *)dict{
    [self setValue:[dict remoteQuantity] forKey:@"quantity"];
}
@end
