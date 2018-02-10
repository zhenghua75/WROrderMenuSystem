//
//  NSDictionary+InventoryCategory.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-13.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import "NSDictionary+Extends.h"

@implementation NSDictionary(Extends)
- (id)objectForKeyReturnNil:(id)key{
    id object = [self objectForKey:key];
	if (object == [NSNull null] || [object isEqual:[NSNull null]])
		return nil;
	return object;
}
- (NSDate *)getJSONDate:(NSString*)jsonDateString{
    if ([jsonDateString length]==0) {
        return nil;
    }
    NSString* header = @"/Date(";
    uint headerLength = (uint)[header length];
    
    NSString*  timestampString;
    
    NSScanner* scanner = [[NSScanner alloc] initWithString:jsonDateString];
    [scanner setScanLocation:headerLength];
    [scanner scanUpToString:@")" intoString:&timestampString];
    
    NSCharacterSet* timezoneDelimiter = [NSCharacterSet characterSetWithCharactersInString:@"+-"];
    NSRange rangeOfTimezoneSymbol = [timestampString rangeOfCharacterFromSet:timezoneDelimiter];
    
    scanner=nil;
    
    if (rangeOfTimezoneSymbol.length!=0) {
        scanner = [[NSScanner alloc] initWithString:timestampString];
        
        NSRange rangeOfMilliSecondNumber;
        rangeOfMilliSecondNumber.location = 0;
        rangeOfMilliSecondNumber.length = rangeOfTimezoneSymbol.location;
        
        NSString* milliSecondNumberString = [timestampString substringWithRange:rangeOfMilliSecondNumber];

        unsigned long long milliSecondNumber = [milliSecondNumberString longLongValue];

        NSTimeInterval secondInterval = milliSecondNumber/1000;
        return [NSDate dateWithTimeIntervalSince1970:secondInterval];
    }
    unsigned long long milliSecondNumber = [timestampString longLongValue];
    NSTimeInterval secondInterval = milliSecondNumber/1000;
    return [NSDate dateWithTimeIntervalSince1970:secondInterval];
}

- (NSString*)getStr:(NSString*)key{
    id obj = [self objectForKeyReturnNil:key];
    if (obj==nil) {
        return nil;
    }
    return [NSString stringWithString:obj];
}
- (NSNumber*)getBool:(NSString*)key{
    id obj = [self objectForKeyReturnNil:key];
    if (obj==nil) {
        return nil;
    }
    return [NSNumber numberWithBool:[obj boolValue]];
}
- (NSNumber*)getInt:(NSString*)key{
    id obj = [self objectForKeyReturnNil:key];
    if (obj==nil) {
        return nil;
    }
    return [NSNumber numberWithInt:[obj intValue]];
}

- (NSDecimalNumber*)getDec:(NSString*)key{
    id obj = [self objectForKeyReturnNil:key];
    if (obj==nil) {
        return nil;
    }
    return [NSDecimalNumber decimalNumberWithDecimal:[obj decimalValue]];
}
- (NSDictionary*)getDict:(NSString*)key{
    id obj = [self objectForKeyReturnNil:key];
    if (obj==nil) {
        return nil;
    }
    return [NSDictionary dictionaryWithDictionary:obj];
}
- (NSArray*)getArray:(NSString*)key{
    id obj = [self objectForKeyReturnNil:key];
    if (obj==nil) {
        return nil;
    }
    return [NSArray arrayWithArray:obj];
}
- (NSString *)remoteId{
    return [self getStr:@"Id"];
}
- (NSString *)remoteCode{
    return [self getStr:@"Code"];
}
- (NSString *)remoteName{
    return [self getStr:@"Name"];
}
- (NSString *)remoteComment{
    return [self getStr:@"Comment"];
}
/////////////////////////////////
- (NSString*)remoteCategory{
    return [self getStr:@"Category"];
}
- (NSString*)remoteEnglishName{
    return [self getStr:@"EnglishName"];
}
- (NSString*)remoteUnitOfMeasure{
    return [self getStr:@"UnitOfMeasure"];
}
- (NSString*)remoteSpecs{
    return [self getStr:@"Specs"];
}
- (NSString*)remoteImageFileName{
    return [self getStr:@"ImageFileName"];
}
- (NSDecimalNumber*)remoteSalePoint{
    return [self getDec:@"SalePoint"];
}
- (NSDecimalNumber*)remoteSalePoint0{
    return [self getDec:@"SalePoint0"];
}
- (NSDecimalNumber*)remoteSalePoint1{
    return [self getDec:@"SalePoint1"];
}
- (NSDecimalNumber*)remoteSalePoint2{
    return [self getDec:@"SalePoint2"];
}
- (NSDecimalNumber*)remoteSalePrice{
    return [self getDec:@"SalePrice"];
}
- (NSDecimalNumber*)remoteSalePrice0{
    return [self getDec:@"SalePrice0"];
}
- (NSDecimalNumber*)remoteSalePrice1{
    return [self getDec:@"SalePrice1"];
}
- (NSDecimalNumber*)remoteSalePrice2{
    return [self getDec:@"SalePrice2"];
}
- (NSNumber*)remoteIsDonate{
    return [self getBool:@"IsDonate"];
}
- (NSNumber*)remoteIsRecommend{
    return [self getBool:@"IsRecommend"];
}
- (NSNumber*)remoteIsPackage{
    return [self getBool:@"IsPackage"];
}
- (NSNumber*)remoteStars{
    return [self getInt:@"Stars"];
}
- (NSNumber*)remoteSort{
    return [self getInt:@"Sort"];
}
- (NSString*)remoteFeature{
    return [self getStr:@"Feature"];
}
- (NSString*)remoteDosage{
    return [self getStr:@"Dosage"];
}
- (NSString*)remotePalette{
    return [self getStr:@"Palette"];
}
- (NSString*)remoteEnglishIntroduce{
    return [self getStr:@"EnglishIntroduce"];
}
- (NSString*)remoteEnglishDosage{
    return [self getStr:@"EnglishDosage"];
}
//////////////////////////////
- (NSString*)remotePackageId{
    return [self getStr:@"PackageId"];
}
- (NSString*)remoteInventoryId{
    return [self getStr:@"InventoryId"];
}
- (NSString*)remoteOptionalGroup{
    return [self getStr:@"OptionalGroup"];
}
- (NSNumber*)remoteIsOptional{
    return [self getBool:@"IsOptional"];
}
///////////////////////////////////////////////////////////
- (NSString*)remoteFileName{
    return [self getStr:@"FileName"];
}
- (NSDate*)remoteModifyDate{
    NSString *s = [self objectForKeyReturnNil:@"ModifyDate"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSDate *d = [dateFormatter dateFromString:s];
    return d;
}
////////////////////
- (NSString *)remoteOrderDishId{
    return [self getStr:@"OrderDishId"];
}
- (NSString *)remoteOrderDeskId{
    return [self getStr:@"OrderDeskId"];
}
- (NSString *)remoteDeskNo{
    return [self getStr:@"DeskNo"];
}
- (NSString *)remoteDeskId{
    return [self getStr:@"DeskId"];
}
- (NSString *)remoteUserId{
    return [self getStr:@"UserId"];
}
- (NSNumber*)remoteStatus{
    return [self getInt:@"Status"];
}
//- (NSString *)StatusName{
//    return [self objectForKey:@"StatusName"];
//}
//////////////////////////////////////////////
- (NSString*)remoteOrderBookId{
    return [self getStr:@"OrderBookId"];
}
- (NSString*)remoteOrderBookDeskId{
    return [self getStr:@"OrderBookDeskId"];
}
- (NSDate*)remoteBookBeginDate{
    NSString *jsonDateString = [self objectForKeyReturnNil:@"BookBeginDate"];
    NSDate *date = [self getJSONDate:jsonDateString];
    return date;
}
- (NSDate*)remoteBookEndDate{
    NSString *jsonDateString = [self objectForKeyReturnNil:@"BookEndDate"];
    NSDate *date = [self getJSONDate:jsonDateString];
    return date;
}
- (NSDate*)remoteCreateDate{
    NSString *jsonDateString = [self objectForKeyReturnNil:@"CreateDate"];
    NSDate *date = [self getJSONDate:jsonDateString];
    return date;
}
- (NSString*)remoteCustomer{
    return [self getStr:@"Customer"];
}
- (NSString*)remoteLinkPhone{
    return [self getStr:@"LinkPhone"];
}
- (NSDecimalNumber*)remoteQuantity{
    return [self getDec:@"Quantity"];
}
- (NSString*)remoteFullName{
    return [self getStr:@"FullName"];
}

- (NSString*)remoteUserName{
    return [self getStr:@"UserName"];
}
/////////////////////////////////////
- (NSString*)remoteOrderMenuId{
    return [self getStr:@"OrderMenuId"];
}
- (NSString*)remoteInvId{
    return [self getStr:@"InvId"];
}
- (NSString*)remoteInvCode{
    return [self getStr:@"InvCode"];
}
- (NSString*)remoteInvName{
    return [self getStr:@"InvName"];
}

- (NSDecimalNumber*)remoteAmount{
    return [self getDec:@"Amount"];
}
- (NSNumber*)remotePackageSn{
    return [self getInt:@"PackageSn"];
}
///////////////////////////////////////////
- (NSDictionary*)remoteOrderDesk{
    return [self getDict:@"OrderDesk"];
}
- (NSArray*)remotelOrderMenu{
    return [self getArray:@"lOrderMenu"];
}
- (NSNumber*)remoteIsAdd{
    return [self getBool:@"IsAdd"];
}
- (NSNumber*)remoteIsDelete{
    return [self getBool:@"IsDelete"];
}
- (NSString*)remoteInventory{
    return [self getStr:@"Inventory"];
}
- (NSArray*)remotelLackMenu{
    return [self getArray:@"lLackMenu"];
}
@end
