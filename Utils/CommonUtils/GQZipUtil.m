//
//  GQZipUtil.m
//  CodeReader
//
//  Created by Gideon on 8/3/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQZipUtil.h"
#import "ZipArchive.h"
#import "GQFolderUtil.h"

@implementation GQZipUtil
+ (BOOL)unZipFileByPath:(NSString *)filePath
{
    BOOL ret;
    ZipArchive* zip = [[ZipArchive alloc] init];
    NSString* unzipto = [[filePath componentsSeparatedByString:@"."] firstObject] ;
    if( [zip UnzipOpenFile:filePath] )
    {
        ret = [zip UnzipFileTo:unzipto overWrite:YES];
        [zip UnzipCloseFile];
    }
    return ret;
}

+ (BOOL)zipFilebyPath:(NSString *)filePath
{
    ZipArchive* zip = [[ZipArchive alloc] init];
    NSString *folderName = [[[[filePath componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] firstObject];
    NSString* l_zipfile = [kDocumentDir stringByAppendingPathComponent:folderName] ;
    
    BOOL ret = [zip CreateZipFile2:l_zipfile];
    ret = [zip addFileToZip:filePath newname:[[filePath componentsSeparatedByString:@"/"] lastObject]];
    if( ![zip CloseZipFile2] )
    {
        l_zipfile = @"";
    }
    return ret;
}
@end
