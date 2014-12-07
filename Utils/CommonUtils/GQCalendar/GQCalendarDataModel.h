//
//  GQCalendarDataModel.h
//  CodeReader
//
//  Created by Gideon on 10/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQCalendarDataModel : NSObject
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString *festivalName;
@end
