//
//  GQFolderUtil.h
//  MapDemo
//
//  Created by gideonqiu on 14-7-29.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//  类文件说明

#import <Foundation/Foundation.h>
#import "GQFolder.h"
#import "GQFile.h"

#define kAppDir         [[NSBundle mainBundle] bundlePath]
#define kTempDir        NSTemporaryDirectory()
#define kLibraryDir     [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kCacheDir       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kDocumentDir    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/** FolderUtil类说明 */
@interface GQFolderUtil : NSObject
+ (void)printFoder:(NSString *)filePath;
+ (NSArray *)getAllFilesInFolder:(GQFolder *)folder;
@end
