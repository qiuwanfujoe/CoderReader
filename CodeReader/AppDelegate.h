//
//  AppDelegate.h
//  CodeReader
//
//  Created by Gideon on 7/12/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTTPServer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HTTPServer *httpServer;
}

@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)shareAppDelegate;
- (void)startServer;
- (void)stopServer;
@end
