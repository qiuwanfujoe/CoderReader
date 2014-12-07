//
//  GQFolder.h
//  MapDemo
//
//  Created by gideonqiu on 14-7-29.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//  类文件说明

#import <Foundation/Foundation.h>
#import "CoderObject.h"

@interface GQFolder : CoderObject

@property (nonatomic, assign) BOOL isShowSubFolder;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, assign) NSInteger deepCount;//文件深度
@property (nonatomic, strong) NSString *folderName;//目录名称
@property (nonatomic, strong) NSString *folderPath;//目录完整路径
@property (nonatomic, strong) NSMutableArray  *subFolders;//子目录
@property (nonatomic, strong) NSMutableArray *files;//文件对象
@property (nonatomic, assign) BOOL isEmptyFolder;

- (void)addSubFolder:(GQFolder *)subFolder;
- (void)enumerateFolderPath:(GQFolder *)folder;
@end
