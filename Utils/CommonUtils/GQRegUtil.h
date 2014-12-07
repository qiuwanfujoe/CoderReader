//
//  GQRegUtil.h
//  CodeReader
//
//  Created by Gideon on 8/2/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQRegUtil : NSObject
+ (BOOL)isValidFileExtention:(NSString *)fileName;
+ (BOOL)isValidImageExtention:(NSString *)fileName;
@end
