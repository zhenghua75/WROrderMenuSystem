//
//  NavViewController.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-8.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "NavViewController.h"

@implementation NavViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"%@",@"NavViewController-didReceiveMemoryWarning");
}

#pragma mark - View lifecycle
- (PhotoDataSource *)data{
    data_ = [[PhotoDataSource alloc] initWithRecommend];
    return data_;
}
- (PhotoDataSource *)data2{
    if (data2_) {
        return data2_;
    }
    if (_categoryId2) {
        data2_ = [[PhotoDataSource alloc] initWithCategory:_categoryId2];
    }
    return data2_;
}
- (void)searchview{
    if (!_searchViewController) {
        _searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    }
    [self.navigationController pushViewController:_searchViewController animated:YES];
}

- (void)reloadData{
    //zhenghua 20180210
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadView];
    });
    
    [self setDataSource1:[self data]];
    [self setDataSource2:[self data2]];
    
    data_=nil;
    data2_=nil;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setDataSource1:[self data]];
    [self setDataSource2:[self data2]];
    data_=nil;
    data2_=nil;
}

- (void)viewDidUnload{
    [super viewDidUnload];
    [self setCategoryId2:nil];
    data_=nil;
    data2_=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    //UINavigationBar *navbar = [[self navigationController] navigationBar];
    //[navbar setAlpha:0];
}
//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [viewController viewWillAppear:animated];
//}

@end
