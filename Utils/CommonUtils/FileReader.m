//
//  FileReader.m
//  CodeReader
//
//  Created by Gideon on 7/27/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "FileReader.h"
#import "GQRegUtil.h"

@implementation FileReader
- (NSString *)loadHTMLHeader:(NSString *)extention
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *fileTemplate = [NSString stringWithFormat:@"%@_header.html", extention];
    NSString *filePath =[resourcePath stringByAppendingPathComponent:fileTemplate];
    NSString*htmlHeader =[[NSString alloc] initWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:nil];
    return htmlHeader;
}

- (NSString *)loadHTMLFooter:(NSString *)extention
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *fileTemplate = [NSString stringWithFormat:@"%@_footer.html", extention];
    NSString *filePath =[resourcePath stringByAppendingPathComponent:fileTemplate];
    NSString*htmlHeader =[[NSString alloc] initWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:nil];
    return htmlHeader;
}

- (NSString *)loadHTMLBody:(NSString *)filePath
{
    NSString *htmlBody =[[NSString alloc] initWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:nil];
    NSString *newString = [htmlBody stringByReplacingOccurrencesOfString:@"\"" withString:@"\'"];
    return newString;
}

+ (id)loadHTMLContent:(NSString *)filePath
{
    FileReader *reader = [[FileReader alloc] init];
    NSString *fileExtention = [filePath pathExtension];
    if ([fileExtention isEqualToString:@"m"] || [fileExtention isEqualToString:@"h"]) {
        fileExtention = @"objc";
    } else if ([GQRegUtil isValidImageExtention:filePath]) {
        return [reader loadImageByPath:filePath];
    }
    
    NSString *header = [reader loadHTMLHeader:fileExtention];
    NSString *body = [reader loadHTMLBody:filePath];
    NSString *footer = [reader loadHTMLFooter:fileExtention];
    
    return [NSString stringWithFormat:@"%@%@%@", header, body, footer];
}

- (UIImage *)loadImageByPath:(NSString *)filePath
{
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

@end
