//
//  KTThumbsViewController.m
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "KTThumbsViewController.h"
#import "KTThumbsView.h"
#import "KTThumbView.h"
#import "KTPhotoScrollViewController.h"
#import "WROrderMenuSystemAppDelegate.h"
@interface KTThumbsViewController (Private)
@end


@implementation KTThumbsViewController

@synthesize dataSource1 = dataSource1_;
@synthesize dataSource2= dataSource2_;
@synthesize dataSource=dataSource_;
@synthesize scrollView1=scrollView1_;
@synthesize scrollView2=scrollView2_;
@synthesize scrollView = scrollView_;
@synthesize thumbsType=thumbsType_;
@synthesize categoryId=_categoryId;
@synthesize deskNo = _deskNo;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        thumbsType_= TwoView;
    }
    return self;
}
- (void)searchview{
    if (!_searchViewController) {
        _searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    }
    [self.navigationController pushViewController:_searchViewController animated:YES];
}
- (void)s1scroll{
    CGPoint offset = scrollView1_.contentOffset;
    offset.y+=4; 
    if (offset.y>scrollView1_.contentSize.height-620-155) {
        offset.y=0;
    }
    // these checks are deliberately placed as close as possible to the contentOffset assignment
    if ( scrollView1_.tracking ) return;
    if ( scrollView1_.dragging ) return;
    if ( scrollView1_.zooming ) return;
    if ( scrollView1_.decelerating ) return;
    
    scrollView1_.contentOffset = offset;
}

- (void)loadView {
    // Make sure to set wantsFullScreenLayout or the photo
    // will not display behind the status bar.
    
    [super loadView];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    //s1Height=0;
    if (thumbsType_==TwoView) {
        CGSize size = self.view.frame.size;
        //CGRectMake(0, 0, 320, size.height)
        KTThumbsView *scrollView1 = [[KTThumbsView alloc] initWithFrame:CGRectZero];
        [scrollView1 setThumbSize:CGSizeMake(240, 163)];
        [scrollView1 setDataSource:self];
        [scrollView1 setController:self];
        [scrollView1 setScrollsToTop:YES];
        [scrollView1 setScrollEnabled:YES];
        [scrollView1 setAlwaysBounceVertical:YES];
        [scrollView1 setBackgroundColor:[UIColor blackColor]];
        scrollView1.tag=1;
        if ([dataSource1_ respondsToSelector:@selector(thumbsHaveBorder)]) {
            [scrollView1 setThumbsHaveBorder:[dataSource1_ thumbsHaveBorder]];
        }
        
        if ([dataSource1_ respondsToSelector:@selector(thumbSize)]) {
            [scrollView1 setThumbSize:[dataSource1_ thumbSize]];
        }
        
        if ([dataSource1_ respondsToSelector:@selector(thumbsPerRow)]) {
            [scrollView1 setThumbsPerRow:[dataSource1_ thumbsPerRow]];
        }
        
        KTThumbsView *scrollView2 = [[KTThumbsView alloc] initWithFrame:CGRectZero];
        [scrollView2 setThumbSize:CGSizeMake(340, 232)];
        [scrollView2 setDataSource:self];
        [scrollView2 setController:self];
        [scrollView2 setScrollsToTop:YES];
        [scrollView2 setScrollEnabled:YES];
        [scrollView2 setAlwaysBounceVertical:YES];
        [scrollView2 setBackgroundColor:[UIColor blackColor]];
        scrollView2.tag=2;
        if ([dataSource2_ respondsToSelector:@selector(thumbsHaveBorder)]) {
            [scrollView2 setThumbsHaveBorder:[dataSource2_ thumbsHaveBorder]];
        }
        
        if ([dataSource2_ respondsToSelector:@selector(thumbSize)]) {
            [scrollView2 setThumbSize:[dataSource2_ thumbSize]];
        }
        
        if ([dataSource2_ respondsToSelector:@selector(thumbsPerRow)]) {
            [scrollView2 setThumbsPerRow:[dataSource2_ thumbsPerRow]];
        }
        
        
        
        
        [scrollView1 setFrame:CGRectMake(0, 44, 240, size.height-44)];
        [scrollView2 setFrame:CGRectMake(250, 0, size.width-250, size.height)];
        
        NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSMutableString * path = [[NSMutableString alloc] initWithString:documentPath];
        [path appendFormat:@"/%@",@"middle-split.tif"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        if (!img) {
            img = [UIImage imageNamed:@"middle-split.tif"];
        }
        
        //UIImage *img = [UIImage imageNamed:@"middle-split.tif"];
        UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
        [imgview setFrame:CGRectMake(240, 44, 10, size.height-44)];
        
        //        UIButton *searchButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        //        [searchButton setTitle:@"快速查找" forState:UIControlStateNormal];
        //        [searchButton setFrame:CGRectMake(0, 0, 50, 44)];
        //        UILabel *lblDeskNo = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 44)];
        //        [lblDeskNo setText:@"09"];
        //        lblDeskNo.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        //        lblDeskNo.backgroundColor = [UIColor clearColor];
        //        lblDeskNo.textColor = [UIColor yellowColor];
        //
        //        UILabel *lblDeskNoText = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 50, 44)];
        //        [lblDeskNoText setText:@"号桌"];
        //        lblDeskNoText.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        //        lblDeskNoText.backgroundColor = [UIColor clearColor];
        //        lblDeskNoText.textColor = [UIColor whiteColor];
        //
        //        UIButton *cameroButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [cameroButton setTitle:@"欢乐拍照" forState:UIControlStateNormal];
        //        [cameroButton setFrame:CGRectMake(150, 0, 140, 44)];
        
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
        toolbar.barStyle = UIBarStyleBlackOpaque;
        
        NSMutableString * path1 = [[NSMutableString alloc] initWithString:documentPath];
        [path1 appendFormat:@"/%@",@"search-40-1.png"];
        UIImage *img1 = [UIImage imageWithContentsOfFile:path1];
        if (!img1) {
            img1 = [UIImage imageNamed:@"search-40-1.png"];
        }
        //UIImage *img1 = [UIImage imageNamed:@"search-40-1.png"];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.bounds = CGRectMake( 0, 0, img1.size.width, img1.size.height );
        [btn1 setImage:img1 forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(searchview) forControlEvents:UIControlEventTouchUpInside];
        
        //        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn2.bounds = CGRectMake( 0, 0, img2.size.width, img2.size.height );
        //        [btn2 setImage:img2 forState:UIControlStateNormal];
        
        
        _deskNo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
        [_deskNo setText:[WROrderMenuSystemAppDelegate orderInfo].orderDesk.deskNo];
        [_deskNo setTextColor:[UIColor yellowColor]];
        [_deskNo setBackgroundColor:[UIColor clearColor]];
        
        UILabel *lblDeskNo1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 35, 44)];
        [lblDeskNo1 setText:@"号桌"];
        [lblDeskNo1 setTextColor:[UIColor whiteColor]];
        [lblDeskNo1 setBackgroundColor:[UIColor clearColor]];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, 44)];
        [view addSubview:_deskNo];
        [view addSubview:lblDeskNo1];
        
        
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:view];
        
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:4];
        [buttons addObject:item1];
        [buttons addObject:item2];
        [toolbar setItems:buttons animated:NO];
        [self.view addSubview:scrollView1];
        [self.view addSubview:scrollView2];
        [self.view addSubview:imgview];
        [self.view addSubview:toolbar];
        scrollView1_ = scrollView1;
        scrollView2_ = scrollView2;
    }
    else if(thumbsType_==OneView){
        KTThumbsView *scrollView = [[KTThumbsView alloc] initWithFrame:CGRectZero];
        [scrollView setDataSource:self];
        [scrollView setController:self];
        [scrollView setScrollsToTop:YES];
        [scrollView setScrollEnabled:YES];
        [scrollView setAlwaysBounceVertical:YES];
        [scrollView setBackgroundColor:[UIColor blackColor]];
        scrollView.tag=0;
        if ([dataSource_ respondsToSelector:@selector(thumbsHaveBorder)]) {
            [scrollView setThumbsHaveBorder:[dataSource_ thumbsHaveBorder]];
        }
        
        if ([dataSource_ respondsToSelector:@selector(thumbSize)]) {
            [scrollView setThumbSize:[dataSource_ thumbSize]];
        }
        
        if ([dataSource_ respondsToSelector:@selector(thumbsPerRow)]) {
            [scrollView setThumbsPerRow:[dataSource_ thumbsPerRow]];
        }
        
        // Set main view to the scroll view.
        [self setView:scrollView];
        scrollView_=scrollView;
    }
    //滚动造成系统不稳定
    //    NSTimer *timer;
    //
    //    timer = [NSTimer scheduledTimerWithTimeInterval: 0.1
    //                                             target: self
    //                                           selector: @selector(s1scroll)
    //                                           userInfo: nil
    //                                            repeats: YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scrollView1 reloadData];
    [self.scrollView2 reloadData];
    [_deskNo setText:[WROrderMenuSystemAppDelegate orderInfo].orderDesk.deskNo];
}

//- (void)viewWillDisappear:(BOOL)animated {
//  // Restore old translucency when we pop this controller.
//  UINavigationBar *navbar = [[self navigationController] navigationBar];
//  [navbar setTranslucent:navbarWasTranslucent_];
//  [super viewWillDisappear:animated];
//}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    [super viewDidUnload];
    [self setDataSource:nil];
    [self setDataSource1:nil];
    [self setDataSource2:nil];
    [self setScrollView:nil];
    [self setScrollView1:nil];
    [self setScrollView2:nil];
    [self setCategoryId:nil];
    [self setDeskNo:nil];
    _searchViewController=nil;
}

- (void)willLoadThumbs {
    // Do nothing by default.
}

- (void)didLoadThumbs {
    // Do nothing by default.
}

- (void)reloadThumbs {
    [self willLoadThumbs];
    [scrollView_ reloadData];
    [self didLoadThumbs];
}
- (void)reloadThumbs1 {
    [self willLoadThumbs];
    [scrollView1_ reloadData];
    [self didLoadThumbs];
}
- (void)reloadThumbs2 {
    [self willLoadThumbs];
    [scrollView2_ reloadData];
    [self didLoadThumbs];
}
- (void)setDataSource1:(id <KTPhotoBrowserDataSource>)newDataSource {
    dataSource1_ = newDataSource;
    [self reloadThumbs1];
}
- (void)setDataSource2:(id <KTPhotoBrowserDataSource>)newDataSource {
    dataSource2_ = newDataSource;
    [self reloadThumbs2];
}
- (void)setDataSource:(id <KTPhotoBrowserDataSource>)newDataSource {
    dataSource_ = newDataSource;
    [self reloadThumbs];
}
- (void)didSelectThumbAtIndex:(NSUInteger)index thumbsView:(KTThumbsView *)thumbsView {
    if (thumbsView==scrollView1_) {
        OrderMenuInfo *oi = [dataSource1_ thumbImageAtIndex:index];
        
        id <KTPhotoBrowserDataSource> pickDataSource = [[PhotoDataSource alloc] initWithCategory:oi.categoryId];
        int selectedInventoryIndex = 0;
        for (int i=0;i<[pickDataSource numberOfPhotos];i++) {
            OrderMenuInfo *orderInv = [pickDataSource thumbImageAtIndex:i];
            if ([orderInv.invId isEqualToString:oi.invId]) {
                selectedInventoryIndex=i;
                break;
            }
            orderInv=nil;
        }
        KTPhotoScrollViewController *newController = [[KTPhotoScrollViewController alloc]
                                                      initWithDataSource:pickDataSource
                                                      andStartWithPhotoAtIndex:selectedInventoryIndex];
        [[self navigationController] pushViewController:newController animated:YES];
        oi=nil;
        pickDataSource=nil;
        newController=nil;
        //[newController1 release];
    } else if(thumbsView==scrollView2_) {
        KTPhotoScrollViewController *newController2 = [[KTPhotoScrollViewController alloc]
                                                       initWithDataSource:dataSource2_
                                                       andStartWithPhotoAtIndex:index];
        [[self navigationController] pushViewController:newController2 animated:YES];
        //[newController2 release];
        newController2=nil;
    }
    else{
        KTPhotoScrollViewController *newController = [[KTPhotoScrollViewController alloc]
                                                      initWithDataSource:dataSource_
                                                      andStartWithPhotoAtIndex:index];
        [[self navigationController] pushViewController:newController animated:YES];
        newController=nil;
    }
}


#pragma mark -
#pragma mark KTThumbsViewDataSource

- (NSInteger)thumbsViewNumberOfThumbs:(KTThumbsView *)thumbsView
{
    if (thumbsView==scrollView1_) {
        NSInteger count = [dataSource1_ numberOfPhotos];
        return count;
    }
    else if(thumbsView==scrollView2_){
        NSInteger count = [dataSource2_ numberOfPhotos];
        return count;
    }
    else{
        NSInteger count = [dataSource_ numberOfPhotos];
        return count;
    }
}

- (KTThumbView *)thumbsView:(KTThumbsView *)thumbsView thumbForIndex:(NSInteger)index
{
    if (thumbsView==scrollView1_) {
        KTThumbView *thumbView = [thumbsView dequeueReusableThumbView];
        if (!thumbView) {
            CGRect frame = CGRectMake(0, 0, scrollView1_.thumbSize.width, scrollView1_.thumbSize.height);
            thumbView = [[KTThumbView alloc] initWithFrame:frame];
            [thumbView setController:self];
            [thumbView setThumbsView:thumbsView];
        }
        
        // Set thumbnail image.
        if ([dataSource1_ respondsToSelector:@selector(thumbImageAtIndex:thumbView:)] == NO) {
            OrderMenuInfo *thumbImage = [dataSource1_ thumbImageAtIndex:index];
            [thumbView setThumbImage:thumbImage size:scrollView1_.thumbSize image:thumbImage.image1];
            //thumbImage.image=nil;
            thumbImage=nil;
        } else {
            // Set thumbnail image asynchronously.
            [dataSource1_ thumbImageAtIndex:index thumbView:thumbView];
        }
        
        return thumbView;
    }
    else if(thumbsView==scrollView2_){
        KTThumbView *thumbView = [thumbsView dequeueReusableThumbView];
        if (!thumbView) {
            CGRect frame = CGRectMake(0, 0, scrollView2_.thumbSize.width, scrollView2_.thumbSize.height);
            thumbView = [[KTThumbView alloc] initWithFrame:frame];
            [thumbView setController:self];
            [thumbView setThumbsView:thumbsView];
        }
        
        // Set thumbnail image.
        if ([dataSource2_ respondsToSelector:@selector(thumbImageAtIndex:thumbView:)] == NO) {
            OrderMenuInfo *thumbImage = [dataSource2_ thumbImageAtIndex:index];
            [thumbView setThumbImage:thumbImage size:scrollView2_.thumbSize image:thumbImage.image2];
            thumbImage=nil;
        } else {
            // Set thumbnail image asynchronously.
            [dataSource2_ thumbImageAtIndex:index thumbView:thumbView];
        }
        
        return thumbView;
    }
    else{
        KTThumbView *thumbView = [thumbsView dequeueReusableThumbView];
        if (!thumbView) {
            thumbView = [[KTThumbView alloc] initWithFrame:CGRectZero];
            [thumbView setController:self];
            [thumbView setThumbsView:thumbsView];
        }
        
        // Set thumbnail image.
        if ([dataSource_ respondsToSelector:@selector(thumbImageAtIndex:thumbView:)] == NO) {
            // Set thumbnail image synchronously.
            OrderMenuInfo *thumbImage = [dataSource_ thumbImageAtIndex:index];
            [thumbView setThumbImage:thumbImage size:scrollView_.thumbSize image:thumbImage.image];
            thumbImage=nil;
        } else {
            // Set thumbnail image asynchronously.
            [dataSource_ thumbImageAtIndex:index thumbView:thumbView];
        }
        
        return thumbView;
    }
}

@end
