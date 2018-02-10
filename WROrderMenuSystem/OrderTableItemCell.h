//
//  OrderTableItemCell.h
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <Three20/Three20.h>
@interface OrderTableItemCell : TTTableLinkedItemCell{
    UILabel* _lblInvName;
    UILabel* _lblSalePrice;
    UIButton* _btnAdd;
    UILabel* _lblCount;
    UIButton* _btnSub;
    UILabel* _lblAmount;
}
@property (nonatomic,retain) UILabel* lblInvName;
@property (nonatomic,retain) UILabel* lblSalePrice;
@property (nonatomic,retain) UIButton* btnAdd;
@property (nonatomic,retain) UILabel*  lblCount;
@property (nonatomic,retain) UIButton* btnSub;
@property (nonatomic,retain) UILabel* lblAmount;
@end
