//
//  GQBaseCell.h
//  CodeReader
//
//  Created by gideonqiu on 14-7-30.
//  Copyright (c) 2014年 GN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Helper.h"

static const CGFloat indentWidth = 5.f;

@interface GQBaseCell : UITableViewCell
+ (NSString *)getCellString:(id)fileObj;
- (void)loadContent:(id)obj;
@end
