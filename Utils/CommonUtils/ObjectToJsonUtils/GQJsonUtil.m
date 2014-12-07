//
//  GQJsonUtil.m
//  MapDemo
//
//  Created by gideonqiu on 14-8-28.
//  Copyright (c) 2014年 gideonqiu. All rights reserved.
//

#import "GQJsonUtil.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation GQJsonUtil
+ (NSString *)objectToJson:(id)object
{
    NSString *jsonString;
    if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *jsonArray = [[self class] arrayToJsonArray:object];
        NSMutableString *strings = [NSMutableString stringWithString:@"["];
        for (NSString *string in jsonArray) {
            [strings appendString:string];
        }
        [strings appendString:@"]"];
        jsonString = strings;
    } else if ([object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSMutableDictionary class]]) {
        NSDictionary *jsonDict = [[self class] dictionaryToJsonDictionary:object];
        jsonString = [[self class] objecToJsonString:jsonDict];
    } else {
        NSDictionary *dict = [[self class] objectToDictionary:object];
       jsonString = [[self class] objecToJsonString:dict];
    }
    return jsonString;
}

+ (NSString *)objecToJsonString:(id)dictionary
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSDictionary *)objectToDictionary:(id)object
{
    Class cls = [object class];
    u_int count;
    objc_property_t *ivars = class_copyPropertyList(cls, &count);
    NSMutableDictionary *objectDict = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; i++) {
        NSString *varName = [NSString stringWithUTF8String:property_getName(ivars[i])];
        NSString *varType = [NSString stringWithUTF8String:getPropertyType(ivars[i])];;
        id varValue = [object valueForKey:varName];
        if ([[self class] isBasicType:varType]) {
            [objectDict setObject:varValue forKey:varName];
        } else {
            NSString *jsonString = [[self class] objectToJson:varValue];
            [objectDict setObject:jsonString forKey:varName];
        }
    }
    
    return objectDict;
}

+ (NSMutableArray *)arrayToJsonArray:(NSArray *)array
{
    NSMutableArray *modelArray = [NSMutableArray array];
    for (id model in array) {
        NSString *jsonString = [[self class] objectToJson:model];
        [modelArray addObject:jsonString];
    }
    return modelArray;
}

+ (NSDictionary *)dictionaryToJsonDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    for (NSString *key in dictionary.allKeys) {
        id objValue = [dictionary valueForKey:key];
        NSString *clsType = NSStringFromClass([objValue class]);
        if ([[self class] isBasicType:clsType]) {
            [jsonDict setObject:objValue forKey:key];
        } else {
            NSString *jsonString = [[self class] objectToJson:objValue];
            [jsonDict setObject:jsonString forKey:key];
        }
    }
    return jsonDict;
}

+ (BOOL)isBasicType:(NSString *)type
{
    if (type.length < 3 || [type isEqualToString:@"NSString"]) {
        return YES;
    }
    return NO;
}

//获取属性的方法
static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            
            // if you want a list of what will be returned for these primitives, search online for
            // "objective-c" "Property Attribute Description Examples"
            // apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
            
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}


@end
