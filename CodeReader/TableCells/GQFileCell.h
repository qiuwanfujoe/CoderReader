//
//  GQFileCell.h
//  CodeReader
//
//  Created by gideonqiu on 14-7-30.
//  Copyright (c) 2014年 GN. All rights reserved.
//  类文件说明

#import "GQBaseCell.h"
#import "GQFile.h"
@protocol GQFileCellDelegate;

/** GQFileCell类说明 */
@interface GQFileCell : GQBaseCell
@property (nonatomic, weak) id<GQFileCellDelegate> delegate;
@property (nonatomic, strong) GQFile *file;

- (void)loadContent:(GQFile *)file;
@end

@protocol GQFileCellDelegate <NSObject>
- (void)showFileContent:(GQFileCell *)fileCell;

@end
