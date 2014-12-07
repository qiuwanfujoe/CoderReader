//
//  GQCalendarDataCenter.h
//  CodeReader
//
//  Created by Gideon on 10/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQCalendarDataCenter : NSObject
@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)prepareWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate currentDate:(NSDate *)currentDate;
@end
