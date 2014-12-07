//
//  NSString+CTExtensions.h
//  CodeReader
//
//  Created by Gideon on 7/29/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CTExtensions)

/**
 *  URL Encode字符串 (非stringByAddingPercentEscapesUsingEncoding方式)
 *
 *  @return URL encode后的字符串
 */
- (NSString *)stringByCFURLEncoding;

/**
 *  URL Dncode字符串 (非stringByReplacingPercentEscapesUsingEncoding方式)
 *
 *  @return URL encode后的字符串
 */
- (NSString *)stringByCFURLDecoding;
/**
 *  消除字符串中的空格和换行
 *
 *  @return 消除了的空格和换行的字符串
 */
- (NSString *)trimmedString;

-(BOOL)isEmpty;
@end
