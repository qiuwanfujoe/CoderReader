//
//  GQDeviceutil.m
//  CodeReader
//
//  Created by Gideon on 8/3/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQDeviceutil.h"

@implementation GQDeviceutil
+ (BOOL)isSystemVersionLarger:(CGFloat)systemVersion
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= systemVersion) {
        return YES;
    }
    return NO;
}
+ (BOOL)isIPhone5
{
    if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))) {
        return YES;
    }
    return NO;
}
@end
