//
//  GQFileCell.m
//  CodeReader
//
//  Created by gideonqiu on 14-7-30.
//  Copyright (c) 2014年 GN. All rights reserved.
//  类文件说明

#import "GQFileCell.h"

@interface GQFileCell()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *fileNameButton;

@end

@implementation GQFileCell
- (void)loadContent:(GQFile *)file
{
    self.file = file;
    [self.fileNameButton setTitle:self.file.fileName forState:UIControlStateNormal];
    
    [self.containerView setViewOriginX:self.file.deepCount*indentWidth];
    
    [self layoutIfNeeded];
}

- (IBAction)showFileContent:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(showFileContent:)]) {
        [self.delegate showFileContent:self];
    }
}

@end
