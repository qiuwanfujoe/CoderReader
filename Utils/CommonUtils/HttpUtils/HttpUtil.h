//
//  HttpUtil.h
//  CodeReader
//
//  Created by Gideon on 8/1/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ip_port 9090

@interface HttpUtil : NSObject
+ (NSString *) localWiFiIPAddress;
+ (NSString *)getWifiName;
@end
