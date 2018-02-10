//
//  ShowMenuInfoCell.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-27.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "ShowMenuInfoCell.h"
#import <QuartzCore/QuartzCore.h>
#import "OrderMenuInfo.h"
#import "WROrderMenuSystemAppDelegate.h"
#import "NSDecimalNumber+Compare.h"
@implementation ShowMenuInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0);
    CGContextSetLineWidth(ctx, 0.25);
    
    CGFloat f = 40.0;
        CGContextMoveToPoint(ctx, f, 0);
        CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
     f = 240;
    CGContextMoveToPoint(ctx, f, 0);
    CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
    
    f = 366;
    CGContextMoveToPoint(ctx, f, 0);
    CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
    
    f = 480;
    CGContextMoveToPoint(ctx, f, 0);
    CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
    
    f = 604;
    CGContextMoveToPoint(ctx, f, 0);
    CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
    
    f = 854;
    CGContextMoveToPoint(ctx, f, 0);
    CGContextAddLineToPoint(ctx, f, self.bounds.size.height);

    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

- (IBAction)subClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    int row = (int)button.tag;
    
    OrderMenuInfo *oi = [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu objectAtIndex:row];
    if ([oi.status isEqualToNumber:[NSNumber numberWithInt:Ordered]]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"加减数量" message:@"前台已确认提交，不能加减数量！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([oi.isPackage boolValue]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"加减数量" message:@"此为套餐，不能加减数量！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([oi.quantity isGreaterThanInt:1]) {
        oi.quantity = [oi.quantity decimalNumberBySubtracting:[NSDecimalNumber one]];
        
        oi.amount= [oi.salePrice decimalNumberByMultiplyingBy:oi.quantity];
        [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu replaceObjectAtIndex:row withObject:oi];
        [self.orderMenuViewController resetTotalMoney];
        //[(UITableView *)self.superview reloadData];
        [self.orderMenuViewController.tableView reloadData];
    }
}

- (IBAction)addClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    int row = (int)button.tag;
    
    OrderMenuInfo *oi = [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu objectAtIndex:row];
    if (oi.status && [oi.status isEqualToNumber:[NSNumber numberWithInt:Ordered]]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"加减数量" message:@"前台已确认提交，不能加减数量！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (oi.isPackage && [oi.isPackage boolValue]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"加减数量" message:@"此为套餐，不能加减数量！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    oi.quantity = [oi.quantity decimalNumberByAdding:[NSDecimalNumber one]];
    oi.amount= [oi.salePrice decimalNumberByMultiplyingBy:oi.quantity] ;
    [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu replaceObjectAtIndex:row withObject:oi];
    oi=nil;
    [self.orderMenuViewController resetTotalMoney];
    [self.orderMenuViewController.tableView reloadData];
}
- (IBAction)commendEdit:(id)sender {
    UITextField *txt = (UITextField *)sender;
    int row = (int)txt.tag;
    
    NSMutableArray *selectedInventories = [WROrderMenuSystemAppDelegate orderInfo].lOrderMenu;
    if ([selectedInventories count]>row) {
        
        OrderMenuInfo *oi = [selectedInventories objectAtIndex:row];
        if ([oi.status isEqualToNumber:[NSNumber numberWithInt:Ordered]]) {
            if (![_commentText.text isEqualToString:oi.comment]) {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"修改" message:@"前台已确认提交，不能修改！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [_commentText setText:oi.comment];
                alert=nil;
            }
            
        }
        else
        {
            if (_commentText.text.length==0) {
                oi.comment=nil;
            }
            else
            {
                oi.comment=_commentText.text;
            }
        }
        oi=nil;
    }
    selectedInventories=nil;
    txt=nil;
}
@end
