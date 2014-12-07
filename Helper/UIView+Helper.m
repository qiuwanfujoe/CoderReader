//
//  UIView+Helper.m
//  CodeReader
//
//  Created by Gideon on 7/29/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)
- (CGFloat)viewWidth
{
    CGRect frame = self.frame;
    return frame.size.width;
}

- (CGFloat)viewHeight
{
    CGRect frame = self.frame;
    return frame.size.height;
}

- (CGFloat)viewOriginX
{
    CGRect frame = self.frame;
    return frame.origin.x;
}

- (CGFloat)viewOriginY
{
    CGRect frame = self.frame;
    return frame.origin.y;
}

- (CGPoint)viewOrigin
{
    CGRect frame = self.frame;
    return frame.origin;
}

- (CGSize)viewSize
{
    CGRect frame = self.frame;
    return frame.size;
}

- (CGPoint)viewCenter
{
    return self.center;
}

- (void)setViewOriginX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setViewOriginY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setViewWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setViewHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setViewOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setViewSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)removeSubviews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (UIImage *) imageByRenderingView {
	CGFloat oldAlpha = self.alpha;
	
	self.alpha = 1;
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	self.alpha = oldAlpha;
	
	return resultingImage;
}

@end

@implementation UIColor(helper)

+ (UIColor *)colorWithHex:(NSString *)hexColor
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"#?[0-9a-f]{6}" options:NSRegularExpressionCaseInsensitive error:NULL];
    
    NSTextCheckingResult *match = [regular firstMatchInString:hexColor options:0 range:NSMakeRange(0, [hexColor length])];
    
    NSRange range = [match range];
    if (range.location == NSNotFound) {
        return [UIColor whiteColor];
    }
    
    NSString *matchText;
    if (range.length == 7) {
        range.location = 1;
        range.length = 6;
    }
    matchText = [hexColor substringWithRange:range];
    
    unsigned int r,g,b;
    
    range.length = 2;
    NSScanner *scanner;
    NSString *colorString;
    
    range.location = 0;
    colorString = [matchText substringWithRange:range];
    scanner = [NSScanner scannerWithString:colorString];
    [scanner scanHexInt:&r];
    
    range.location = 2;
    colorString = [matchText substringWithRange:range];
    scanner = [NSScanner scannerWithString:colorString];
    [scanner scanHexInt:&g];
    
    range.location = 4;
    colorString = [matchText substringWithRange:range];
    scanner = [NSScanner scannerWithString:colorString];
    [scanner scanHexInt:&b];
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

@end
