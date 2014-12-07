//
//  UIView+Helper.h
//  CodeReader
//
//  Created by Gideon on 7/29/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)
- (CGFloat)viewWidth;
- (CGFloat)viewHeight;
- (CGFloat)viewOriginX;
- (CGFloat)viewOriginY;
- (CGPoint)viewOrigin;
- (CGSize)viewSize;

- (void)setViewOriginX:(CGFloat)x;
- (void)setViewOriginY:(CGFloat)y;
- (void)setViewWidth:(CGFloat)width;
- (void)setViewHeight:(CGFloat)height;
- (void)setViewOrigin:(CGPoint)origin;
- (void)setViewSize:(CGSize)size;
- (void)removeSubviews;
- (UIImage *)imageByRenderingView;
@end

@interface UIColor(helper)
+ (UIColor *)colorWithHex:(NSString *)hexColor;
@end
