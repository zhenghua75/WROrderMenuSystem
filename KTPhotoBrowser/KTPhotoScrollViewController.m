//
//  KTPhotoScrollViewController.m
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/4/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "KTPhotoScrollViewController.h"
#import "KTPhotoBrowserDataSource.h"
#import "KTPhotoView.h"
#import "WROrderMenuSystemAppDelegate.h"

const CGFloat ktkDefaultPortraitToolbarHeight   = 44;
const CGFloat ktkDefaultLandscapeToolbarHeight  = 33;
const CGFloat ktkDefaultToolbarHeight = 120;

#define BUTTON_DELETEPHOTO 0
#define BUTTON_CANCEL 1

@interface KTPhotoScrollViewController (KTPrivate)
- (void)setCurrentIndex:(NSInteger)newIndex;
- (void)swapCurrentAndNextPhotos;
- (void)nextPhoto;
- (void)previousPhoto;
- (void)toggleNavButtons;
- (CGRect)frameForPagingScrollView;
- (CGRect)frameForPageAtIndex:(NSUInteger)index;
- (void)loadPhoto:(NSInteger)index;
- (void)unloadPhoto:(NSInteger)index;
@end

@implementation KTPhotoScrollViewController
@synthesize currentIndex=currentIndex_;
- (id)initWithDataSource:(id <KTPhotoBrowserDataSource>)dataSource andStartWithPhotoAtIndex:(NSUInteger)index
{
    if (self = [super init]) {
        startWithIndex_ = index;
        dataSource_ = dataSource;
        dataSource=nil;
    }
    return self;
}

- (void)backToFront{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self unloadPhoto:currentIndex_];
    [self unloadPhoto:currentIndex_ + 1];
    [self unloadPhoto:currentIndex_ - 1];
    [self unloadPhoto:currentIndex_ + 2];
    [self unloadPhoto:currentIndex_ - 2];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self unloadPhoto:currentIndex_];
    [self unloadPhoto:currentIndex_ + 1];
    [self unloadPhoto:currentIndex_ - 1];
    [self unloadPhoto:currentIndex_ + 2];
    [self unloadPhoto:currentIndex_ - 2];
}
- (void)loadView {
    [super loadView];
    CGRect scrollFrame = [self frameForPagingScrollView];
    UIScrollView *newView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    [newView setDelegate:self];
    UIColor *backgroundColor = [dataSource_ respondsToSelector:@selector(imageBackgroundColor)] ?
    [dataSource_ imageBackgroundColor] : [UIColor blackColor];
    [newView setBackgroundColor:backgroundColor];
    //newView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [newView setAutoresizesSubviews:YES];
    [newView setPagingEnabled:YES];
    [newView setShowsVerticalScrollIndicator:NO];
    [newView setShowsHorizontalScrollIndicator:NO];
    [newView setScrollsToTop:NO];
    [newView setContentSize:CGSizeMake(940, 528.75)];
    
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSMutableString * path = [[NSMutableString alloc] initWithString:documentPath];
    [path appendFormat:@"/%@",@"back-right.png"];
    UIImage *imgnext = [UIImage imageWithContentsOfFile:path];
    if (!imgnext) {
        imgnext = [UIImage imageNamed:@"back-right.png"];
    }
    
    //UIImage *imgnext = [UIImage imageNamed:@"back-right.png"];
    UIButton *btnnext = [UIButton buttonWithType:UIButtonTypeCustom];
    btnnext.bounds = CGRectMake( 0, 0, imgnext.size.width, 46.25 );
    [btnnext setImage:imgnext forState:UIControlStateNormal];
    imgnext=nil;
    [btnnext addTarget:self action:@selector(nextPhoto) forControlEvents:UIControlEventTouchUpInside];
    nextButton_ = [[UIBarButtonItem alloc] initWithCustomView:btnnext];
    btnnext=nil;
    
    NSMutableString * path1 = [[NSMutableString alloc] initWithString:documentPath];
    [path1 appendFormat:@"/%@",@"pre-left-46.png"];
    UIImage *imgpre = [UIImage imageWithContentsOfFile:path1];
    if (!imgpre) {
        imgpre = [UIImage imageNamed:@"pre-left-46.png"];
    }
    //UIImage *imgpre = [UIImage imageNamed:@"pre-left-46.png"];
    UIButton *btnpre = [UIButton buttonWithType:UIButtonTypeCustom];
    btnpre.bounds = CGRectMake( 0, 0, imgpre.size.width, 46.25 );
    [btnpre setImage:imgpre forState:UIControlStateNormal];
    imgpre=nil;
    [btnpre addTarget:self action:@selector(previousPhoto) forControlEvents:UIControlEventTouchUpInside];
    previousButton_ = [[UIBarButtonItem alloc] initWithCustomView:btnpre];
    btnpre=nil;
    
    NSMutableString * path2 = [[NSMutableString alloc] initWithString:documentPath];
    [path2 appendFormat:@"/%@",@"back-home-46.png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path2];
    if (!img) {
        img = [UIImage imageNamed:@"back-home-46.png"];
    }
    //UIImage *img = [UIImage imageNamed:@"back-home-46.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake( 0, 0, img.size.width, 46.25 );
    [btn setImage:img forState:UIControlStateNormal];
    img=nil;
    [btn addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
    backButton_ = [[UIBarButtonItem alloc] initWithCustomView:btn];
    btn=nil;
    
    
    UIBarItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                     target:nil
                                                                     action:nil];
    
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithCapacity:7];
    
    
    [toolbarItems addObject:backButton_];
    [toolbarItems addObject:space];
    [toolbarItems addObject:previousButton_];
    [toolbarItems addObject:space];
    [toolbarItems addObject:nextButton_];
    [toolbarItems addObject:space];
    
    CGRect toolbarFrame = CGRectMake(0, 646.75, 940, 61);
    UIToolbar *toolbar_ = [[UIToolbar alloc] initWithFrame:toolbarFrame];
    [toolbar_ setBarStyle:UIBarStyleBlack];
    toolbar_.translucent=NO;
    [toolbar_ setItems:toolbarItems];
    [[self view] addSubview:toolbar_];
    toolbar_=nil;
    
    
    view_ = [[UIView alloc] initWithFrame:CGRectMake(0, 528.75, 949, 118)];
    view_.backgroundColor = [UIColor blackColor];
    //view_.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    view_.userInteractionEnabled=NO;
    
    lblStar = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 36)];
    lblStar.font = [UIFont fontWithName:@"STHeitiSC-Light" size:36];
    lblStar.backgroundColor = [UIColor clearColor];
    lblStar.textColor = [UIColor whiteColor];
    
    
    lblInventoryName = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, 300, 36)];
    lblInventoryName.font = [UIFont fontWithName:@"STHeitiSC-Light" size:36];
    lblInventoryName.backgroundColor = [UIColor clearColor];
    lblInventoryName.textColor = [UIColor whiteColor];
    lblInventoryName.adjustsFontSizeToFitWidth=YES;
    
    lblEnglishName = [[UILabel alloc] initWithFrame:CGRectMake(0, 72, 300, 36)];
    lblEnglishName.font = [UIFont fontWithName:@"STHeitiSC-Light" size:20];
    lblEnglishName.backgroundColor = [UIColor clearColor];
    lblEnglishName.textColor = [UIColor whiteColor];
    lblEnglishName.adjustsFontSizeToFitWidth=YES;
    //////////产品介绍
    //newImage.feature
    lblfeature = [[UILabel alloc] initWithFrame:CGRectMake(300, 0, 420, 20)];
    lblfeature.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
    lblfeature.backgroundColor = [UIColor clearColor];
    lblfeature.textColor = [UIColor whiteColor];
    
    //英文介绍
    lblEnglishIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(300, 20, 420, 20)];
    lblEnglishIntroduce.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
    lblEnglishIntroduce.backgroundColor = [UIColor clearColor];
    lblEnglishIntroduce.textColor = [UIColor whiteColor];
    
    //产品配料
    //newImage.dosage
    lbldosage = [[UILabel alloc] initWithFrame:CGRectMake(300, 40, 420, 20)];
    lbldosage.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
    lbldosage.backgroundColor = [UIColor clearColor];
    lbldosage.textColor = [UIColor whiteColor];
    
    //配料英文
    lblEnglishDosage = [[UILabel alloc] initWithFrame:CGRectMake(300, 60, 420, 20)];
    lblEnglishDosage.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
    lblEnglishDosage.backgroundColor = [UIColor clearColor];
    lblEnglishDosage.textColor = [UIColor whiteColor];
    
    //建议搭配
    //newImage.palette
    lblpalette = [[UILabel alloc] initWithFrame:CGRectMake(300, 80, 420, 20)];
    lblpalette.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
    lblpalette.backgroundColor = [UIColor clearColor];
    lblpalette.textColor = [UIColor whiteColor];
    
    ///单价
    lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(720, 0, 254, 100)];
    lblPrice.font = [UIFont fontWithName:@"STHeitiSC-Light" size:40];
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.textColor = [UIColor yellowColor];
    
    
    //下单按钮
    addButton = [MyButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(940-50,50, 32, 32)];
    
    [view_ addSubview:lblStar];
    [view_ addSubview:lblInventoryName];
    [view_ addSubview:lblEnglishName];
    [view_ addSubview:lblfeature];
    [view_ addSubview:lbldosage];
    [view_ addSubview:lblpalette];
    [view_ addSubview:lblEnglishDosage];
    [view_ addSubview:lblEnglishIntroduce];
    [view_ addSubview:lblPrice];
    
    [self.view addSubview:view_];
    
    [self.view addSubview:newView];
    [self.view insertSubview:addButton aboveSubview:newView];
    
    //self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    scrollView_ = newView;
    
    toolbarItems=nil;
    newView=nil;
    space=nil;
}

-(void)setInfo{
    OrderMenuInfo *orderInventory = [dataSource_ thumbImageAtIndex:currentIndex_];
    id delegate = [[UIApplication sharedApplication] delegate];
    addButton.omi = orderInventory;
    [delegate menuButtonImgAndAction:addButton];
    
    NSMutableString *star = [[NSMutableString alloc] init];
    for (int i=0; i<[orderInventory.stars intValue]; i++) {
        [star appendString:@"★"];
    }
    lblStar.text = star;
    star=nil;
    
    lblInventoryName.text = orderInventory.invName;
    lblEnglishName.text = orderInventory.englishName;
    lblfeature.text = orderInventory.feature;
    lbldosage.text = orderInventory.dosage;
    lblpalette.text = orderInventory.palette;
    lblPrice.text = [NSString stringWithFormat:@"￥%.2f元",[orderInventory.salePrice doubleValue]];
    lblEnglishIntroduce.text = orderInventory.englishIntroduce;
    lblEnglishDosage.text = orderInventory.englishDosage;
    
    orderInventory=nil;
}
- (void)scrollToIndex:(NSInteger)index
{
    CGRect frame = scrollView_.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    [scrollView_ scrollRectToVisible:frame animated:NO];
}

- (void)setScrollViewContentSize
{
    NSInteger pageCount = photoCount_;
    if (pageCount == 0) {
        pageCount = 1;
    }
    
    CGSize size = CGSizeMake(scrollView_.frame.size.width * pageCount,1);
    [scrollView_ setContentSize:size];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    photoCount_ = [dataSource_ numberOfPhotos];
    [self setScrollViewContentSize];
    
    photoViews_ = [[NSMutableArray alloc] initWithCapacity:photoCount_];
    for (int i=0; i < photoCount_; i++) {
        [photoViews_ addObject:[NSNull null]];
    }
}
-(void)viewDidUnload{
    
    dataSource_=nil;
    scrollView_=nil;
    view_=nil;
    photoViews_=nil;
    nextButton_=nil;
    previousButton_=nil;
    backButton_=nil;
    addButton=nil;
    lblInventoryName=nil;
    lblfeature=nil;
    lbldosage=nil;
    lblpalette=nil;
    lblPrice=nil;
    lblStar=nil;
    lblEnglishName=nil;
    lblEnglishIntroduce=nil;
    lblEnglishDosage=nil;
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setScrollViewContentSize];
    [self setCurrentIndex:startWithIndex_];
    [self scrollToIndex:startWithIndex_];
    [self toggleNavButtons];
}


- (void)toggleNavButtons
{
    [previousButton_ setEnabled:(currentIndex_ > 0)];
    [nextButton_ setEnabled:(currentIndex_ < photoCount_ - 1)];
}


#pragma mark -
#pragma mark Frame calculations
#define PADDING  0//20

- (CGRect)frameForPagingScrollView
{
    CGRect frame = CGRectMake(0, 0, 940, 528.75); //[[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return frame;
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index
{
    CGRect bounds = [scrollView_ bounds];
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    return pageFrame;
}


#pragma mark -
#pragma mark Photo (Page) Management

- (void)loadPhoto:(NSInteger)index
{
    //NSLog(@"loadPhoto%2f",scrollView_.bounds.size.height);
    if (index < 0 || index >= photoCount_) {
        return;
    }
    
    id currentPhotoView = [photoViews_ objectAtIndex:index];
    if (NO == [currentPhotoView isKindOfClass:[KTPhotoView class]]) {
        // Load the photo view.
        CGRect frame = [self frameForPageAtIndex:index];
        KTPhotoView *photoView = [[KTPhotoView alloc] initWithFrame:frame];
        [photoView setScroller:self];
        [photoView setIndex:index];
        [photoView setBackgroundColor:[UIColor clearColor]];
        
        // Set the photo image.
        if (dataSource_) {
            if ([dataSource_ respondsToSelector:@selector(imageAtIndex:photoView:)] == NO) {
                OrderMenuInfo *image = [dataSource_ imageAtIndex:index];
                image.image = [UIImage imageWithContentsOfFile:image.imageFileName];
                [photoView setImage:image];
                image.image=nil;
                image=nil;
            } else {
                [dataSource_ imageAtIndex:index photoView:photoView];
            }
        }
        
        [scrollView_ addSubview:photoView];
        [photoViews_ replaceObjectAtIndex:index withObject:photoView];
        photoView=nil;
        //[photoView release];
    } else {
        // Turn off zooming.
        [currentPhotoView turnOffZoom];
    }
}

- (void)unloadPhoto:(NSInteger)index
{
    if (index < 0 || index >= photoCount_) {
        return;
    }
    @autoreleasepool {
        id currentPhotoView = [photoViews_ objectAtIndex:index];
        if ([currentPhotoView isKindOfClass:[KTPhotoView class]]) {
            [currentPhotoView removeFromSuperview];
            [photoViews_ replaceObjectAtIndex:index withObject:[NSNull null]];
            currentPhotoView=nil;
        }
    }
}

- (void)setCurrentIndex:(NSInteger)newIndex
{
    currentIndex_ = newIndex;
    
    [self loadPhoto:currentIndex_];
    [self loadPhoto:currentIndex_ + 1];
    [self loadPhoto:currentIndex_ - 1];
    [self unloadPhoto:currentIndex_ + 2];
    [self unloadPhoto:currentIndex_ - 2];
    [self toggleNavButtons];
    [self setInfo];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = floor(fractionalPage);
	if (page != currentIndex_) {
		[self setCurrentIndex:page];
	}
}

#pragma mark -
#pragma mark Toolbar Actions

- (void)nextPhoto 
{
    [self scrollToIndex:currentIndex_ + 1];
}

- (void)previousPhoto 
{
    [self scrollToIndex:currentIndex_ - 1];
}


@end
