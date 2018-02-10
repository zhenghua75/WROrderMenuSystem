//
//  MenuStatus.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 13-6-30.
//  Copyright (c) 2013年 kmdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuStatus : NSObject
@property NSString *id;
@property NSString *inventory;
@property NSNumber *status;
- (id)initWithDictionary:(NSDictionary*)dict;
@end
