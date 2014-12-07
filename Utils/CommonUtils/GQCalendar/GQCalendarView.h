//
//  GQCalendarView.h
//  CodeReader
//
//  Created by Gideon on 10/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQCalendarView : UIView

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

- (void)prepareWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate currentDate:(NSDate *)currentDate;

@end
