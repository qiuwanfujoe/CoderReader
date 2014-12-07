//
//  GQFolderCell.h
//  CodeReader
//
//  Created by gideonqiu on 14-7-30.
//  Copyright (c) 2014年 GN. All rights reserved.
//  类文件说明

#import "GQBaseCell.h"
#import "GQFolder.h"
@protocol GQFolderCellDelegate;

@interface GQFolderCell : GQBaseCell
@property (nonatomic, weak) id<GQFolderCellDelegate> delegate;
@property (nonatomic, strong) GQFolder *folder;

- (void)loadContent:(GQFolder *)folder;
@end

@protocol GQFolderCellDelegate <NSObject>
- (void)showFolderContent:(GQFolderCell *)folderCell;
- (void)hideFolderContent:(GQFolderCell *)folderCell;
@end
