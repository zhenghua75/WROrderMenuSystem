//
//  KTPhotoBrowserDataSource.h
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/7/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderMenuInfo.h"
@class KTPhotoView;
@class KTThumbView;

@protocol KTPhotoBrowserDataSource <NSObject>
@required
- (NSInteger)numberOfPhotos;

@optional

// Implement either these, for synchronous images…
- (OrderMenuInfo *)imageAtIndex:(NSInteger)index;
- (OrderMenuInfo *)thumbImageAtIndex:(NSInteger)index;

// …or these, for asynchronous images.
- (void)imageAtIndex:(NSInteger)index photoView:(KTPhotoView *)photoView;
- (void)thumbImageAtIndex:(NSInteger)index thumbView:(KTThumbView *)thumbView;

- (void)deleteImageAtIndex:(NSInteger)index;
- (void)exportImageAtIndex:(NSInteger)index;

- (CGSize)thumbSize;
- (NSInteger)thumbsPerRow;
- (BOOL)thumbsHaveBorder;
- (UIColor *)imageBackgroundColor;

@end
