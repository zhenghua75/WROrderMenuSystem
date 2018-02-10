//
//  KTPhotoView.h
//  Sample
//
//  Created by Kirby Turner on 2/24/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderMenuInfo.h"
@class KTPhotoScrollViewController;

@interface KTPhotoView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView_;
    KTPhotoScrollViewController *scroller_;
    NSInteger index_;
}

@property (nonatomic, strong) KTPhotoScrollViewController *scroller;
@property (nonatomic, assign) NSInteger index;

- (void)setImage:(OrderMenuInfo *)newImage;
- (void)turnOffZoom;

- (CGPoint)pointToCenterAfterRotation;
- (CGFloat)scaleToRestoreAfterRotation;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale;


@end
