//
//  GQBaseCell.m
//  CodeReader
//
//  Created by gideonqiu on 14-7-30.
//  Copyright (c) 2014年 GN. All rights reserved.
//

#import "GQBaseCell.h"
#import "GQFolder.h"
#import "GQFile.h"

@implementation GQBaseCell

+ (NSString *)getCellString:(id)fileObj
{
    if ([fileObj isKindOfClass:[GQFolder class]]) {
        return @"GQFolderCell";
    } else if ([fileObj isKindOfClass:[GQFile class]]) {
        return @"GQFileCell";
    }
    return nil;
}

- (void)loadContent:(id)obj
{

}

@end
