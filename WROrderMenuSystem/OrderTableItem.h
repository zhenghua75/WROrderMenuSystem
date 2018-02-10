//
//  OrderTableItem.h
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderInventory.h"
#import <extThree20JSON/extThree20JSON.h>
#import <Three20/Three20.h>
@interface OrderTableItem : TTTableLinkedItem{
    OrderInventory* _orderInventory;
}
@property (nonatomic,retain) OrderInventory* orderInventory;
+(id)itemWithText:(OrderInventory*)orderInventory;
@end
