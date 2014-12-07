//
//  GQDeviceutil.h
//  CodeReader
//
//  Created by Gideon on 8/3/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQDeviceutil : NSObject
+ (BOOL)isSystemVersionLarger:(CGFloat)systemVersion;
+ (BOOL)isIPhone5;
@end
