//
//  GQZipUtil.h
//  CodeReader
//
//  Created by Gideon on 8/3/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQZipUtil : NSObject
+ (BOOL)unZipFileByPath:(NSString *)filePath;
+ (BOOL)zipFilebyPath:(NSString *)filePath;
@end
