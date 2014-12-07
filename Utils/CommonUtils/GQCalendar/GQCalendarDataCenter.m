//
//  GQCalendarDataCenter.m
//  CodeReader
//
//  Created by Gideon on 10/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQCalendarDataCenter.h"
#import "GQCalendarDataModel.h"
#import "GQDateButton.h"
// 日历使用到的时区信息
#define kCtripCalendarTimeZone_CN @"Asia/Shanghai"

@interface GQCalendarDataCenter ()
@property (nonatomic, strong) NSCalendar *calendar;
@end

@implementation GQCalendarDataCenter
- (id)init
{
    self = [super init];
    if (self) {
        [self initBaseData];
    }
    return self;
}

- (void)initBaseData
{
    if (!self.calendar) {
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [self.calendar setFirstWeekday:1];
        [self.calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [self.calendar setMinimumDaysInFirstWeek:1];
        [self.calendar setTimeZone:[NSTimeZone timeZoneWithName:kCtripCalendarTimeZone_CN]];
    }
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
}

#pragma mark 通过日期获取该月内周数
- (int)getWeeksOfMonth:(NSDate *)date
{
    int weeks = [self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
    return weeks;
}

#pragma mark 通过日期获取该周内天数
- (int)getDaysOfWeek:(NSDate *)date
{
    int days = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date].length;
    return days;
}

- (void)prepareWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate currentDate:(NSDate *)currentDate
{
    if (!startDate || !endDate) {
        NSLog(@"初始化日期为空！！！");
        return;
    }
    uint unitFlags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    NSDate *startDate_ = nil;
    NSDate *endDate_ = nil;
    NSDate *currentDate_ = nil;
    
    //初始化当前日期
    if (currentDate) {
        NSDateComponents *currentDateComponents = [self.calendar components:unitFlags fromDate:currentDate];
        currentDate_ = [self.calendar dateFromComponents:currentDateComponents];
    }
    
    //比较起始日期与结束日期大小
    if (NSOrderedAscending == [startDate compare:endDate]) {
        startDate_ = startDate;
        endDate_ = endDate;
    } else {
        startDate_ = endDate;
        endDate_ = startDate;
    }
    
    //获取起始日期与结束日期的年月日
    NSDateComponents *startDateComponents = [self.calendar components:unitFlags fromDate:startDate_];
    int startYear = [startDateComponents year];
    int startMonth = [startDateComponents month];
    int startDay = [startDateComponents day];
    
    NSDateComponents *endDateComponents = [self.calendar components:unitFlags fromDate:endDate_];
    int endYear = [endDateComponents year];
    int endMonth = [endDateComponents month];
    int endDay = [endDateComponents day];
    
    //创建日期数据结构
    for (int year = startYear; year <= endYear; year++) {
        int sMonth = 1, eMonth = 12;
        if (year == startYear) {
            sMonth = startMonth;
        }
        if (year == endYear) {
            eMonth = endMonth;
        }
        for (int month = sMonth; month <= eMonth; month++) {
            NSMutableDictionary *monthDictionary = [NSMutableDictionary dictionary];
            NSMutableArray *weekArray = [NSMutableArray array];
            
            //每月的第一天
            NSDateComponents *componentsForMonth = [[NSDateComponents alloc] init];
            componentsForMonth.year = year;
            componentsForMonth.month = month;
            componentsForMonth.day = 1;
            NSDate *firstDayOfMonth = [self.calendar dateFromComponents:componentsForMonth];
            int weekDayNumber = [[self.calendar components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth] weekday];
            
            int dayNumber = 1;
            int weeksOfMonth = [self getWeeksOfMonth:firstDayOfMonth];
            
            for (int week = 1; week <= weeksOfMonth; week++) {
                NSMutableArray *dayArray = [NSMutableArray array];
                NSDateComponents *componentsForWeek = [[NSDateComponents alloc] init];
                componentsForWeek.year = year;
                componentsForWeek.month = month;
                componentsForWeek.day = dayNumber;
                
                NSDate *firstDayDateOfWeek = [self.calendar dateFromComponents:componentsForWeek];
                int daysOfWeek = [self getDaysOfWeek:firstDayDateOfWeek];
                
                for (int day = 0; day < 7; day++) {
                    [dayArray addObject:[NSNull null]];
                }
                for (int dayInWeek = 0; dayInWeek < daysOfWeek; dayInWeek++) {
                    GQCalendarDataModel *dayModel = [[GQCalendarDataModel alloc] init];
                    dayModel.year = year;
                    dayModel.month = month;
                    dayModel.day = dayNumber;
                    dayModel.state = eGQDateButtonStateNormal;
                    
                    if (year == startYear && month == startMonth && dayNumber < startDay) {
                        dayModel.state = eGQDateButtonStateDisable;
                    }
                    
                    if (year == endYear && month == endMonth && dayNumber > endDay) {
                        dayModel.state = eGQDateButtonStateDisable;
                    }
                    
                    if (week == 1) {
                        [dayArray replaceObjectAtIndex:weekDayNumber+dayInWeek-1 withObject:dayModel];
                    } else {
                        [dayArray replaceObjectAtIndex:dayInWeek withObject:dayModel];
                    }
                    dayNumber++;
                }
                [weekArray addObject:dayArray];
            }
            [monthDictionary setValue:weekArray forKey:[NSString stringWithFormat:@"%d年%02d月", year, month]];
            [self.dataArray addObject:monthDictionary];
        }
    }
}
@end
