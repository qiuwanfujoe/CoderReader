//
//  FileReader.h
//  CodeReader
//
//  Created by Gideon on 7/27/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileReader : NSObject
+ (id)loadHTMLContent:(NSString *)filePath;
@end
