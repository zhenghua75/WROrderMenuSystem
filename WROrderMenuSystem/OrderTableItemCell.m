//
//  OrderTableItemCell.m
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "OrderTableItemCell.h"
#import "OrderTableItem.h"
#import "WROrderMenuSystemAppDelegate.h"
static CGFloat kHPadding = 10;
static CGFloat kVPadding = 10;
//static CGFloat kMargin = 10;
//static CGFloat kSpacing = 8;
//static CGFloat kControlPadding = 8;
//static CGFloat kGroupMargin = 10;
//static CGFloat kDefaultTextViewLines = 5;
//
//static CGFloat kKeySpacing = 12;
static CGFloat kKeyWidth = 75;
static CGFloat kButtonHeight=37;
//static CGFloat kMaxLabelHeight = 2000;
//static CGFloat kDisclosureIndicatorWidth = 23;
//
//static CGFloat kDefaultIconSize = 50;

@implementation OrderTableItemCell
@synthesize lblInvName=_lblInvName,lblSalePrice=_lblSalePrice,btnAdd=_btnAdd,lblCount=_lblCount,btnSub=_btnSub,lblAmount=_lblAmount;
//+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
//    
//}
-(void)addCount{
    OrderTableItem* item = self.object;
    item.orderInventory.count = item.orderInventory.count+1;
    item.orderInventory.amount= [[
                                  [NSDecimalNumber decimalNumberWithDecimal:item.orderInventory.salePrice] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",item.orderInventory.count]]] decimalValue] ;
    [(UITableView *)self.superview reloadData];
}
-(void)subCount{
    OrderTableItem* item = self.object;
    if (item.orderInventory.count>1) {
        item.orderInventory.count = item.orderInventory.count-1;
        
        item.orderInventory.amount= [[
                                      [NSDecimalNumber decimalNumberWithDecimal:item.orderInventory.salePrice] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",item.orderInventory.count]]] decimalValue] ;
        
        [(UITableView *)self.superview reloadData];
    }
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
        _item = nil;
        
        self.lblInvName = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.lblInvName];
        
        self.lblSalePrice = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.lblSalePrice];
        
        self.btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];//[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnAdd setTitle:@"+" forState:UIControlStateNormal];
        [self.btnAdd addTarget:self action:@selector(addCount) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btnAdd];
        
        self.lblCount = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.lblCount];
        
        self.btnSub = [UIButton buttonWithType:UIButtonTypeRoundedRect];//[[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnSub setTitle:@"-" forState:UIControlStateNormal];
        [self.btnSub addTarget:self action:@selector(subCount) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btnSub];
        
        self.lblAmount = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.lblAmount];
        
        
	}
	return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize titleSize = [@"M" sizeWithFont:self.lblInvName.font];
    self.lblInvName.frame = CGRectMake(kHPadding, kVPadding, kKeyWidth, titleSize.height);
    self.lblSalePrice.frame = CGRectMake(kHPadding*2+kKeyWidth, kVPadding, kKeyWidth, titleSize.height);
    self.btnAdd.frame = CGRectMake(kHPadding*3+kKeyWidth*2, kVPadding, kKeyWidth, kButtonHeight);
    self.lblCount.frame = CGRectMake(kHPadding*4+kKeyWidth*3, kVPadding, kKeyWidth, titleSize.height);
    self.btnSub.frame = CGRectMake(kHPadding*5+kKeyWidth*4, kVPadding, kKeyWidth, kButtonHeight);
    self.lblAmount.frame = CGRectMake(kHPadding*6+kKeyWidth*5, kVPadding, kKeyWidth, titleSize.height);
}

- (id)object {
	return _item;
}
-(void)setObject:(id)object{
    if (_item != object) {
        [super setObject:object];
        
        OrderTableItem* item = object;
        
        self.lblInvName.text = item.orderInventory.invName;
        
        self.lblSalePrice.text = [NSString stringWithFormat:@"%.2f", [[NSDecimalNumber decimalNumberWithDecimal:item.orderInventory.salePrice] doubleValue]];
        self.lblCount.text =[NSString stringWithFormat:@"%d" ,item.orderInventory.count];
        self.lblAmount.text = [NSString stringWithFormat:@"%.2f", [[NSDecimalNumber decimalNumberWithDecimal:item.orderInventory.amount] doubleValue]];
        
        //self.btnAdd.titleLabel.text = @"+";
        //[self.btnAdd setTitle:@"123456" forState:UIControlStateNormal];
        //self.btnSub.titleLabel.text = @"-";
        
    }
}
@end
