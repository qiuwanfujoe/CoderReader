//
//  GQUploadFileCell.m
//  CodeReader
//
//  Created by Gideon on 8/2/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQUploadFileCell.h"

@interface GQUploadFileCell()
@property (weak, nonatomic) IBOutlet UIButton *uploadFileButton;

@end

@implementation GQUploadFileCell

- (void)loadUploadFileCell:(NSString *)filePath
{
    self.filePath = filePath;
    NSString *fileName = [[self.filePath componentsSeparatedByString:@"/"] lastObject];
    
    [self.uploadFileButton setTitle:fileName forState:UIControlStateNormal];
}

- (IBAction)showFileContent:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(showFileContent:)]) {
        [self.delegate showFileContent:self];
    }
}

@end
