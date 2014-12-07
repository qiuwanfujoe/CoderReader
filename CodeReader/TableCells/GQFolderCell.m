//
//  GQFolderCell.m
//  CodeReader
//
//  Created by gideonqiu on 14-7-30.
//  Copyright (c) 2014年 GN. All rights reserved.
//  类文件说明

#import "GQFolderCell.h"

@interface GQFolderCell()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *folderIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *folderNameButton;

@end

@implementation GQFolderCell

- (void)loadContent:(GQFolder *)folder
{
    self.folder = folder;
    [self.folderNameButton setTitle:self.folder.folderName forState:UIControlStateNormal];
    [self.containerView setViewOriginX:self.folder.deepCount * indentWidth ];
    self.folderIconImageView.image = self.folder.isShowSubFolder ? [UIImage imageNamed:@"down_arrow.png"] : [UIImage imageNamed:@"right_arrow.png"];
    [self layoutIfNeeded];
}

- (IBAction)showFolderContent:(id)sender
{
    self.folder.isShowSubFolder = !self.folder.isShowSubFolder;
    if (self.folder.isShowSubFolder) {
        self.folderIconImageView.image = [UIImage imageNamed:@"down_arrow.png"];
        if ([self.delegate respondsToSelector:@selector(showFolderContent:)]) {
            [self.delegate showFolderContent:self];
        }
    } else {
        self.folderIconImageView.image = [UIImage imageNamed:@"right_arrow.png"];
        if ([self.delegate respondsToSelector:@selector(hideFolderContent:)]) {
            [self.delegate hideFolderContent:self];
        }
    }
}

@end
