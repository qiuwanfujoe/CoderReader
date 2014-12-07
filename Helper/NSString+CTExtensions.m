//
//  NSString+CTExtensions.m
//  CodeReader
//
//  Created by Gideon on 7/29/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "NSString+CTExtensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CTExtensions)

- (NSString *)stringByCFURLEncoding
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                     (CFStringRef)self,
                                                                     NULL,
                                                                     (CFStringRef)@"!*'\"();:@&=+$,/?%#[]%",
                                                                     kCFStringEncodingUTF8));
}

- (NSString *)stringByCFURLDecoding
{
	return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
}

- (NSString *)trimmedString
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(BOOL)isEmpty{
    return self == nil || self.length == 0 || [self trimmedString].length == 0;
}
@end
