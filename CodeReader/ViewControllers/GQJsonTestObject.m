//
//  GQJsonTestObject.m
//  CodeReader
//
//  Created by Gideon on 8/30/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQJsonTestObject.h"

@implementation GQJsonTestObject
- (instancetype)init
{
    if (self = [super init]) {
        self.students = [NSMutableArray array];
        self.dicts = [NSMutableDictionary dictionary];
    }
    return self;
}
@end

@implementation Student

@end