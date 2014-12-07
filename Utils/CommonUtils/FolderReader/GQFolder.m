//
//  GQFolder.m
//  MapDemo
//
//  Created by gideonqiu on 14-7-29.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//  类文件说明

#import "GQFolder.h"
#import "GQFolderUtil.h"
#import "GQFile.h"
#import "GQZipUtil.h"

@implementation GQFolder
- (id)init
{
    self = [super init];
    if (self) {
        self.subFolders = [NSMutableArray array];
        self.files = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmptyFolder
{
    return self.subFolders.count <= 0 && self.files.count <= 0;
}

- (NSString *)folderName
{
    return [[_folderPath componentsSeparatedByString:@"/"] lastObject];
}

- (void)addSubFolder:(GQFolder *)subFolder
{
    [self.subFolders addObject:subFolder];
    [subFolder enumerateFolderPath:subFolder];
}

- (void)enumerateFolderPath:(GQFolder *)folder
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contentOfFolder = [fileManager contentsOfDirectoryAtPath:folder.folderPath error:NULL];
    for (NSString *filePath in contentOfFolder) {
        if ([[filePath pathExtension] isEqualToString:@"zip"]) {
            [GQZipUtil unZipFileByPath:[folder.folderPath stringByAppendingPathComponent:filePath]];
            //删除老的zip包
            if (access([[folder.folderPath stringByAppendingPathComponent:filePath] UTF8String], 0) == 0) {
                remove([[folder.folderPath stringByAppendingPathComponent:filePath] UTF8String]);
            }
        }
    }
    
    for (NSString *filePath in contentOfFolder) {
        NSString * fullPath = [folder.folderPath stringByAppendingPathComponent:filePath];
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir]) {
            if ([filePath hasPrefix:@"__MACOSX"]) {
                continue;
            }
            if (isDir) {
                GQFolder *subFolder = [[GQFolder alloc] init];
                subFolder.folderPath = fullPath;
                subFolder.folderName = [subFolder folderName];
                subFolder.deepCount = self.deepCount + 1;
                [self addSubFolder:subFolder];
            } else {
                GQFile *file = [[GQFile alloc] init];
                file.filePath = fullPath;
                file.fileName = [file fileName];
                file.deepCount = self.deepCount + 1;
                if (![file.filePath hasSuffix:@".DS_Store"]) {
                    [self.files addObject:file];
                }
            }
        }
    }
}

@end
