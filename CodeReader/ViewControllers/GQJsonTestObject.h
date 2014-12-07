//
//  GQJsonTestObject.h
//  CodeReader
//
//  Created by Gideon on 8/30/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQJsonTestObject : NSObject
@property (nonatomic, strong) NSMutableArray *students;
@property (nonatomic, strong) NSMutableDictionary *dicts;
@end

@interface Student : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger identify;
@property (nonatomic, assign) BOOL flag;
@end
