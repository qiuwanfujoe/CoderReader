//
//  GQJsonUtil.h
//  MapDemo
//
//  Created by gideonqiu on 14-8-28.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQJsonUtil : NSObject
+ (NSString *)objectToJson:(id)object;
+ (BOOL)isBasicType:(id)type;
@end
