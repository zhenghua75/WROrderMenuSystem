//
//  OrderViewDataSource.m
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "OrderViewDataSource.h"
#import "OrderTableItem.h"
#import "WROrderMenuSystemAppDelegate.h"
#import "OrderTableItemCell.h"
#import "OrderInventory.h"
@implementation OrderViewDataSource

//NSDecimal CPDecimalFromString(NSString *stringRepresentation) { 
//    NSDecimal result; 
//    NSScanner *theScanner = [[NSScanner alloc] initWithString:stringRepresentation]; 
//    [theScanner scanDecimal:&result]; 
//    [theScanner release]; return result; 
//} 
+(OrderViewDataSource *)orderViewDataSource{
    NSMutableArray* array = [WROrderMenuSystemAppDelegate inventories];
//    OrderInventory* oi = [[OrderInventory alloc] init];
//    oi.invName = @"test"; 
//    oi.salePrice = [[NSDecimalNumber decimalNumberWithString:@"11.1"] decimalValue];
//    oi.count = 1;
//    oi.amount = [[NSDecimalNumber decimalNumberWithString:@"11.1"] decimalValue];
//    [array addObject:oi];
//    [oi release];
    NSMutableArray *arrayItem = [[NSMutableArray alloc] init];
    for (int i=0; i<[array count]; i++) {
        OrderTableItem* item = [OrderTableItem itemWithText:[array objectAtIndex:i] ];
        [arrayItem addObject:item];
    }
    OrderViewDataSource *dataSource = [[OrderViewDataSource alloc]  initWithItems:arrayItem];
    return dataSource;
}

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
	
	if ([object isKindOfClass:[OrderTableItem class]]) { 
		return [OrderTableItemCell class]; 		
	} else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}



- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell
forRowAtIndexPath:(NSIndexPath*)indexPath {
	cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了删除");
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.items removeObjectAtIndex:indexPath.row];
        NSArray *objects = [NSArray arrayWithObjects:indexPath, nil];
        [tableView deleteRowsAtIndexPaths:objects
                         withRowAnimation:UITableViewRowAnimationBottom];
        [[WROrderMenuSystemAppDelegate inventories] removeObjectAtIndex:indexPath.row];
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    NSLog(@"手指撮动了");
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

@end
