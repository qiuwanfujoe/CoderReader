//
//  GQRegUtil.m
//  CodeReader
//
//  Created by Gideon on 8/2/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQRegUtil.h"

@implementation GQRegUtil
+ (BOOL)isValidFileExtention:(NSString *)fileName
{
    NSString *reg = @"^.*?\.(h|m|sh|md|js|css|ruby|html|php|jpg|png|jpeg|bmp|gif)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    BOOL isValid = [predicate evaluateWithObject:fileName];
    return isValid;
}

+ (BOOL)isValidImageExtention:(NSString *)fileName
{
    NSString *reg = @"^.*?\.(jpg|png|jpeg|bmp|gif)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    BOOL isValid = [predicate evaluateWithObject:fileName];
    return isValid;
}

@end
