//
//  OrderMenuCell.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-28.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "OrderMenuCell.h"

@implementation OrderMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0);
    CGContextSetLineWidth(ctx, 0.25);
    
    CGFloat f = 40.0;
    CGContextMoveToPoint(ctx, f, 0);
    CGContextAddLineToPoint(ctx, f, self.bounds.size.height);

    f = 240.0;
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
@end
