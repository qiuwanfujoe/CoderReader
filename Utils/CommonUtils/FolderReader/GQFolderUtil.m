//
//  FolderUtil.m
//  MapDemo
//
//  Created by gideonqiu on 14-7-29.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//  类文件说明

#import "GQFolderUtil.h"
#import "GQRootFolder.h"
#import "GQFile.h"
#import "GQFolder.h"

@interface GQFolderUtil()
@property (nonatomic, strong) NSMutableArray *fileArray;
@end

@implementation GQFolderUtil

- (id)init
{
    if (self = [super init]) {
        _fileArray = [NSMutableArray array];
    }
    return self;
}

+ (void)printFoder:(NSString *)filePath
{
    if (!filePath) {
        return;
    }
    GQRootFolder *rootFolder = [[GQRootFolder alloc] initWithRootPath:filePath];
    GQFolderUtil *util = [[GQFolderUtil alloc] init];
    [util printFolderPath:rootFolder];
}


- (void)printFolderPath:(GQFolder *)fodler
{
    for (GQFile *file in fodler.files) {
        NSLog(@"文件：%@", file.fileName);
    }
    
    for ( GQFolder *subFolder in fodler.subFolders) {
        NSLog(@"目录：%@", subFolder.folderName);
        if (![subFolder isEmptyFolder]) {
            [self printFolderPath:subFolder];
        }
    }
}

- (void)enumerateFolder:(GQFolder *)folder
{
    for (GQFile *file in folder.files) {
        if (file.isShowing) {
            [_fileArray addObject:file];
        }
    }
    
    for ( GQFolder *subFolder in folder.subFolders) {
        if (subFolder.isShowing) {
            [_fileArray addObject:subFolder];
        }
        if (![subFolder isEmptyFolder]) {
            [self enumerateFolder:subFolder];
        }
    }
}

+ (NSArray *)getAllFilesInFolder:(GQFolder *)folder
{
    GQFolderUtil *util = [[GQFolderUtil alloc] init];
    [util enumerateFolder:folder];
    return util.fileArray;
}
@end
