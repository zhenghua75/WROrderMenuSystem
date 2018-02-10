//
//  NSDecimalNumber+Compare.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-21.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber(Compare)
- (NSComparisonResult)compareWithInt:(int)i;
- (BOOL)isEqualToInt:(int)i;
- (BOOL)isGreaterThanInt:(int)i;
- (BOOL)isGreaterThanOrEqualToInt:(int)i;
- (BOOL)isLessThanInt:(int)i;
- (BOOL)isLessThanOrEqualToInt:(int)i;
@end
