//
//  OrderInventory.m
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//  Modified by zheng hua on 13-6-12
//  简化类

#import "OrderMenuInfo.h"
#import "NSManagedObject+Extends.h"
#import "NSDictionary+Extends.h"

@implementation OrderMenuInfo
- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}
- (id)copyWithZone:(NSZone *)zone{
    OrderMenuInfo *oi= [[OrderMenuInfo alloc] init];
    oi.invId=_invId;
    oi.invCode=_invCode;
    oi.invName=_invName;
    oi.salePrice=_salePrice;
    oi.quantity=_quantity;
    oi.amount=_amount;
    oi.imageFileName=_imageFileName;
    oi.stars=_stars;
    oi.feature=_feature;
    oi.dosage=_dosage;
    oi.palette=_palette;
    oi.image=_image;
    oi.englishName=_englishName;
    //oi.IsConfirmed=_IsConfirmed;
    oi.englishDosage=_englishDosage;
    oi.englishIntroduce=_englishIntroduce;
    oi.imageFileName1=_imageFileName1;
    oi.imageFileName2=_imageFileName2;
    oi.image1=_image1;
    oi.image2=_image2;
    oi.categoryId=_categoryId;
    oi.comment=_comment;
    oi.orderMenuId=_orderMenuId;
    oi.isAdd=_isAdd;
    oi.status=_status;
    oi.isPackage=_isPackage;
    oi.packageId = _packageId;
    oi.packageSn=_packageSn;
    oi.isDelete = _isDelete;
    //oi.StatusName = _StatusName;
    oi.isRecommend = _isRecommend;
    return oi;
}
- (id)initWithManagedObject:(NSManagedObject*)mo{
    @autoreleasepool {
        self = [super init];
        if (self) {
            [self setInvId:[mo localId]];
            [self setCategoryId:[mo localCategory]];
            [self setInvName:[mo localName]];
            [self setSalePrice:[mo localSalePrice]];
            [self setQuantity:[NSDecimalNumber one]];
            [self setAmount:[mo localSalePrice]];
            
            NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSMutableString * path = [[NSMutableString alloc] initWithString:documentPath];
            NSMutableString * path1 = [[NSMutableString alloc] initWithString:documentPath];
            NSMutableString * path2 = [[NSMutableString alloc] initWithString:documentPath];
            NSString *imageFileName = [mo localImageFileName];
            NSString *imageFileName1 = [NSString stringWithFormat:@"%@%@",imageFileName,@"_1.jpg"];
            NSString *imageFileName2 = [NSString stringWithFormat:@"%@%@",imageFileName,@"_2.jpg"];
            [path appendFormat:@"/%@",imageFileName];
            [path1 appendFormat:@"/%@",imageFileName1];
            [path2 appendFormat:@"/%@",imageFileName2];
            
            [self setImageFileName:path];
            [self setImageFileName1:path1];
            [self setImageFileName2:path2];
            UIImage *img1 = [UIImage imageWithContentsOfFile:path1];
            UIImage *img2 = [UIImage imageWithContentsOfFile:path2];
            [self setImage1:img1];
            [self setImage2:img2];
            
            [self setStars:[mo localStars]];
            [self setFeature:[mo localFeature]];
            [self setDosage:[mo localDosage]];
            [self setPalette:[mo localPalette]];
            [self setEnglishIntroduce:[mo localEnglishIntroduce]];
            [self setEnglishDosage:[mo localEnglishDosage]];
            [self setEnglishName:[mo localEnglishName]];
            
            [self setOrderMenuId:nil];
            [self setComment:nil];
            [self setIsPackage:[mo localIsPackage]];
            [self setPackageId:nil];
            
            [self setIsAdd:0];
            [self setIsDelete:0];
            [self setIsRecommend:[mo localIsRecommend]];
            
            img1=nil;
            img2=nil;
            path=nil;
            path1=nil;
            path2=nil;
            imageFileName=nil;
            imageFileName1=nil;
            imageFileName2=nil;
            
        }
        
        return self;
    }
}
- (id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        [self setOrderMenuId:[dict remoteOrderMenuId]];
        [self setInvId:[dict remoteInvId]];
        [self setInvName:[dict remoteInvName]];
        [self setEnglishName:[dict remoteEnglishName]];
        [self setSalePrice:[dict remoteSalePrice]];
        [self setQuantity:[dict remoteQuantity]];
        [self setAmount:[dict remoteAmount]];
        [self setIsAdd:[dict remoteIsAdd]];
        [self setIsDelete:[dict remoteIsDelete]];
        [self setComment:[dict remoteComment]];
        [self setStatus:[dict remoteStatus]];
        [self setIsPackage:[dict remoteIsPackage]];
        [self setPackageId:[dict remotePackageId]];
        [self setPackageSn:[dict remotePackageSn]];
    }
    
    return self;
}
- (NSDictionary*)toDictionary{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:_orderMenuId forKey:@"OrderMenuId"];
    [dict setValue:_invId forKey:@"InvId"];
    [dict setValue:_salePrice forKey:@"SalePrice"];
    [dict setValue:_quantity forKey:@"Quantity"];
    [dict setValue:_amount forKey:@"Amount"];
    [dict setValue:_isAdd forKey:@"IsAdd"];
    [dict setValue:_isDelete forKey:@"IsDelete"];
    [dict setValue:_comment forKey:@"Comment"];
    [dict setValue:_status forKey:@"Status"];
    [dict setValue:_isPackage forKey:@"IsPackage"];
    [dict setValue:_packageId forKey:@"PackageId"];
    [dict setValue:_packageSn forKey:@"PackageSn"];
    return dict;
}
@end
