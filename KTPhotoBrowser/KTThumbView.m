//
//  KTThumbView.m
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "KTThumbView.h"
#import "KTThumbsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WROrderMenuSystemAppDelegate.h"

@implementation KTThumbView

@synthesize controller = controller_;
@synthesize thumbsView=thumbsView_;
@synthesize controller1=controller1_;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addTarget:self
                 action:@selector(didTouch:)
       forControlEvents:UIControlEventTouchUpInside];
        
        CGSize size = frame.size;
        addButton = [MyButton buttonWithType:UIButtonTypeCustom];
        [addButton setFrame:CGRectMake(size.width-32-10,10, 32, 32)];
        
        CGFloat vh = 28;
        BOOL haveStar = NO;
        //       if (size.width==240) {
        //           vh=28;
        //       }
        if (size.width==340) {
            vh=40;
            haveStar=YES;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, size.height-vh-1, size.width, vh)];
        view.backgroundColor = [UIColor blackColor];
        view.userInteractionEnabled=NO;
        
        UIView *viewWhite = [[UIView alloc] initWithFrame:CGRectMake(0, vh-1, size.width, 1)];
        viewWhite.backgroundColor = [UIColor whiteColor];
        if (haveStar) {
            lblStar = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 90, 20)];
            lblStar.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15];
            lblStar.backgroundColor = [UIColor clearColor];
            lblStar.textColor = [UIColor whiteColor];
            
            lblInventoryName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 20)];
            lblInventoryName.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
            lblInventoryName.backgroundColor = [UIColor clearColor];
            lblInventoryName.textColor = [UIColor whiteColor];
            lblInventoryName.adjustsFontSizeToFitWidth=YES;
            
            lblEnglishName = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 220, 20)];
            lblEnglishName.font = [UIFont fontWithName:@"Courier-Bold" size:15];
            lblEnglishName.backgroundColor = [UIColor clearColor];
            lblEnglishName.textColor = [UIColor whiteColor];
            lblEnglishName.adjustsFontSizeToFitWidth=YES;
            
            lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(220, 20, 120, 20)];
            lblPrice.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
            lblPrice.backgroundColor = [UIColor clearColor];
            lblPrice.textColor = [UIColor whiteColor];
            
            [view addSubview:lblInventoryName];
            [view addSubview:lblEnglishName];
            [view addSubview:lblStar];
            [view addSubview:lblPrice];
        }
        else{
            
            lblInventoryName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, vh)];
            lblInventoryName.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15];
            lblInventoryName.backgroundColor = [UIColor clearColor];
            lblInventoryName.textColor = [UIColor whiteColor];
            lblInventoryName.adjustsFontSizeToFitWidth=YES;
            
            lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 100, vh)];
            lblPrice.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15];
            lblPrice.backgroundColor = [UIColor clearColor];
            lblPrice.textColor = [UIColor whiteColor];
            
            [view addSubview:lblInventoryName];
            [view addSubview:lblPrice];
        }
        [view addSubview:viewWhite];
        [self addSubview:view];
        view=nil;
        [self addSubview:addButton];
    }
    return self;
}

- (void)didTouch:(id)sender
{
    if (controller_) {
        [controller_ didSelectThumbAtIndex:[self tag] thumbsView:thumbsView_];
    }
    if (controller1_) {
        [controller1_ didSelectThumbAtIndex:[self tag] thumbsView:thumbsView_];
    }
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat vh = 28;
    //    if (contentRect.size.width==240) {
    //
    //        vh=28;
    //    }
    if (contentRect.size.width==340) {
        vh=40;
    }
    contentRect.size.height=contentRect.size.height-vh;
    return contentRect;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat vh = 28;
    //    if (contentRect.size.width==240) {
    //        vh=28;
    //    }
    if (contentRect.size.width==340) {
        vh=40;
    }
    return CGRectMake(0, contentRect.size.height-vh, contentRect.size.width, vh);
}
- (void)setThumbImage:(OrderMenuInfo *)newImage size:(CGSize)size image:(UIImage *)image
{
    _orderInventory=newImage;
    
    [self setImage:image forState:UIControlStateNormal];
    image=nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    addButton.omi = newImage;
    [delegate menuButtonImgAndAction:addButton];
    
    
    BOOL haveStar = NO;
    if (size.width==340) {
        haveStar=YES;
    }
    
    if (haveStar) {
        NSMutableString *star = [[NSMutableString alloc] init];
        for (int i=0; i<[newImage.stars intValue]; i++) {
            [star appendString:@"★"];
        }
        lblStar.text = star;
        lblEnglishName.text = newImage.englishName;
    }
    lblInventoryName.text = newImage.invName;
    lblPrice.text = [NSString stringWithFormat:@"￥%.2f元",[newImage.salePrice doubleValue]];
}

- (void)setHasBorder:(BOOL)hasBorder
{
    if (hasBorder) {
        self.layer.borderColor = [UIColor colorWithWhite:0 alpha:1.0].CGColor;
        self.layer.borderWidth = 1;
    } else {
        self.layer.borderColor = nil;
    }
}
-(void)dealloc{
    controller_=nil;
    controller1_=nil;
    addButton=nil;
    lblEnglishName=nil;
    lblInventoryName=nil;
    lblPrice=nil;
    lblStar=nil;
    _orderInventory=nil;
    thumbsView_=nil;
}

@end
