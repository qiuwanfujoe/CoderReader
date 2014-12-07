//
//  CodeDisplayViewController.h
//  CodeReader
//
//  Created by Gideon on 7/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeDisplayViewController : UIViewController
@property (nonatomic, strong) NSString *filePath;
- (void)loadContentWithFilePath:(NSString *)filePath;
@end
