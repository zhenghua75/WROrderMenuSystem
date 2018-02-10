//
//  OrderTableItem.m
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "OrderTableItem.h"

@implementation OrderTableItem
@synthesize orderInventory=_orderInventory;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _orderInventory = nil;
    }
    
    return self;
}
+(id)itemWithText:(OrderInventory*)orderInventory{
    OrderTableItem *item = [[self alloc] init];
    item.orderInventory = orderInventory;
    return item;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.orderInventory = [aDecoder decodeObjectForKey:@"orderInventory"];
    }
    return self;    
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    if (self.orderInventory) {
        [aCoder encodeObject:self.orderInventory forKey:@"orderInventory"];
    }
}
@end
