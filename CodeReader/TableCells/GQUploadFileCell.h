//
//  GQUploadFileCell.h
//  CodeReader
//
//  Created by Gideon on 8/2/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GQUploadFileCellDelegate;

@interface GQUploadFileCell : UITableViewCell
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, weak) id<GQUploadFileCellDelegate> delegate;
- (void)loadUploadFileCell:(NSString *)filePath;
@end

@protocol GQUploadFileCellDelegate <NSObject>
- (void)showFileContent:(GQUploadFileCell *)fileCell;
@end
