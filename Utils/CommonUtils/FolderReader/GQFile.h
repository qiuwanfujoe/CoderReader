//
//  GQFile.h
//  MapDemo
//
//  Created by gideonqiu on 14-7-29.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//  类文件说明

#import <Foundation/Foundation.h>
#import "CoderObject.h"

@interface GQFile : CoderObject

@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, assign) NSInteger deepCount;//文件深度
@property (nonatomic, strong) NSString *fileName;//文件名称
@property (nonatomic, strong) NSString *filePath;//文件完整路径
@property (nonatomic, strong) NSString *fileContent;//文件内容

@end
