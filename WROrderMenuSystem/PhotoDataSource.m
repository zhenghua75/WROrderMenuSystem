//
//  PhotoDataSource.m
//  ReallyBigPhotoLibrary
//
//  Created by Kirby Turner on 9/14/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "PhotoDataSource.h"
#import "WROrderMenuSystemAppDelegate.h"
@implementation PhotoDataSource
- (void)GetInventory:(NSString*)strCategoryId{
    @autoreleasepool {
        id delegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dict = [delegate inventoriesOfCategory];
        data_=[dict objectForKey:strCategoryId];
        dict=nil;
        delegate=nil;
    }
}
- (void)GetRecommendInventory{
    @autoreleasepool {
        id delegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dict = [delegate inventoriesOfCategory];
        data_=[dict objectForKey:@"this is a recommend category"];
        dict=nil;
        delegate=nil;
    }
}

- (id)initWithCategory:(NSString*)inventoryCategory{
    [self GetInventory:inventoryCategory];
    return self;
}
- (id)initWithRecommend{
    [self GetRecommendInventory];
    return self;
}
- (NSInteger)numberOfPhotos{
    return [data_ count];
}

- (OrderMenuInfo *)GetImg:(NSInteger)index{
    if (index<0) {
        index=0;
    }
    if (data_==nil) {
        return nil;
    }
    return [data_ objectAtIndex:index];
}
- (OrderMenuInfo *)imageAtIndex:(NSInteger)index{
    return [self GetImg:index];
}

- (OrderMenuInfo *)thumbImageAtIndex:(NSInteger)index{
    return [self GetImg:index];
}

- (void)dealloc{
    data_=nil;
}

@end
