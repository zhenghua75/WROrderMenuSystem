//
//  NSDecimalNumber+Compare.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-21.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import "NSDecimalNumber+Compare.h"

@implementation NSDecimalNumber(Compare)
- (NSComparisonResult)compareWithInt:(int)i{
    return [self compare:[NSNumber numberWithInt:i]];
}

- (BOOL)isEqualToInt:(int)i{
    return [self compareWithInt:i] == NSOrderedSame;
}

- (BOOL)isGreaterThanInt:(int)i{
    return [self compareWithInt:i] == NSOrderedDescending;
}

- (BOOL)isGreaterThanOrEqualToInt:(int)i{
    return [self isGreaterThanInt:i] || [self isEqualToInt:i];
}

- (BOOL)isLessThanInt:(int)i{
    return [self compareWithInt:i] == NSOrderedAscending;
}

- (BOOL)isLessThanOrEqualToInt:(int)i{
    return [self isLessThanInt:i] || [self isEqualToInt:i];
}
@end
