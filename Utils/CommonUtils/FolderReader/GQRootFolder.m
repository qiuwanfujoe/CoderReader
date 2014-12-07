//
//  GQRootFolder.m
//  MapDemo
//
//  Created by gideonqiu on 14-7-29.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//  类文件说明

#import "GQRootFolder.h"


@implementation GQRootFolder
- (GQRootFolder *)initWithRootPath:(NSString *)folderPath
{
    self = [super init];
    if (self) {
        self.folderPath = folderPath;
        [self enumerateFolderPath:self];
    }
    return self;
}
@end
