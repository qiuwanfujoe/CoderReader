//
//  GQFile.m
//  MapDemo
//
//  Created by gideonqiu on 14-7-29.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//  类文件说明

#import "GQFile.h"

@implementation GQFile

- (NSString *)fileContent
{
    NSString *content = [NSString stringWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:NULL];
    return content;
}

- (NSString *)fileName
{
    return [[_filePath componentsSeparatedByString:@"/"] lastObject];
}

@end
