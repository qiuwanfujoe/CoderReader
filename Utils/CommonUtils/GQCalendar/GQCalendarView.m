//
//  GQCalendarView.m
//  CodeReader
//
//  Created by Gideon on 10/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQCalendarView.h"
#import "GQCalendarDataCenter.h"
#import "GQCalendarCell.h"
#import "GQCalendarMonthCell.h"
#import "GQSelectNumberView.h"

@interface GQCalendarView() <UITableViewDataSource, UITableViewDelegate, GQCalendarCelldelegate, GQSelectNumberViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) GQCalendarDataCenter *calendarDataCenter;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation GQCalendarView

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)prepareWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate currentDate:(NSDate *)currentDate
{
    self.startDate = startDate;
    self.endDate = endDate;
    self.calendarDataCenter = [[GQCalendarDataCenter alloc] init];
    [self.calendarDataCenter prepareWithStartDate:self.startDate endDate:self.endDate currentDate:currentDate];
    [self.tableView reloadData];
}

#pragma mark - UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.calendarDataCenter.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [self.calendarDataCenter.dataArray objectAtIndex:section];
    NSArray *weekArray = [[dic allValues] objectAtIndex:0];
    if (weekArray.count < 6) {
        return 8;
    } else {
        return weekArray.count + 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.calendarDataCenter.dataArray objectAtIndex:indexPath.section];
    NSArray *weekArray = [[dic allValues] objectAtIndex:0];
    
    if (indexPath.row == 0) {
        GQCalendarMonthCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"GQCalendarMonthCell"];
        if (!tableCell) {
            tableCell = [[[NSBundle mainBundle] loadNibNamed:@"GQCalendarMonthCell" owner:self options:nil] objectAtIndex:0];
        }
        NSDictionary *monthDic = [self.calendarDataCenter.dataArray objectAtIndex:indexPath.section];
        NSString *monthString = [[monthDic allKeys] objectAtIndex:0];
        tableCell.monthLabel.text = monthString;
        return tableCell;
    } else if (indexPath.row == 1) {
        UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"GQCalendarWeekCell"];
        if (!tableCell) {
            tableCell = [[[NSBundle mainBundle] loadNibNamed:@"GQCalendarWeekCell" owner:self options:nil] objectAtIndex:0];
        }
        return tableCell;
    } else if (indexPath.row - 2 < weekArray.count) {
        GQCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GQCalendarCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GQCalendarCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.delegate = self;
        cell.indexPath = indexPath;
        NSDictionary *monthDic = [self.calendarDataCenter.dataArray objectAtIndex:indexPath.section];
        NSArray *weekArray = [[monthDic allValues] objectAtIndex:0];
        NSArray *daysArray = [weekArray objectAtIndex:indexPath.row-2];
        [cell setDayButtonWithWeekArray:daysArray];
        return cell;
    } else {    
        return [[UITableViewCell alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)calendarcell:(GQCalendarCell *)calendarCell dayBtnClicked:(GQDateButton *)button
{
    NSIndexPath *indexPath = calendarCell.indexPath;
    NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    
    if (indexPath) {
        CGRect newFrame = [self.tableView convertRect:calendarCell.frame toView:self];

        NSDictionary *monthDic = [self.calendarDataCenter.dataArray objectAtIndex:indexPath.section];
        NSMutableArray *weekArray = [[monthDic allValues] objectAtIndex:0];
        [weekArray insertObject:[NSMutableArray array] atIndex:insertIndexPath.row-2];
        self.selectedIndexPath = insertIndexPath;
        
        [self.tableView insertRowsAtIndexPaths:@[insertIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        GQSelectNumberView *selectNumberView = [[[NSBundle mainBundle] loadNibNamed:@"GQSelectNumberView" owner:self options:nil] firstObject];
        selectNumberView.delegate = self;
        selectNumberView.frame = CGRectMake(newFrame.origin.x, newFrame.origin.y+44, selectNumberView.frame.size.width, selectNumberView.frame.size.height);
        [self addSubview:selectNumberView];
    }
}

- (void)selectNumberView:(GQSelectNumberView *)selectNumberView selectNumber:(NSInteger)number
{
    [selectNumberView removeFromSuperview];
    NSDictionary *monthDic = [self.calendarDataCenter.dataArray objectAtIndex:self.selectedIndexPath.section];
    NSMutableArray *weekArray = [[monthDic allValues] objectAtIndex:0];
    [weekArray removeObjectAtIndex:self.selectedIndexPath.row-2];
    [self.tableView deleteRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

- (void)selectNumberView:(GQSelectNumberView *)selectNumberView close:(UIButton *)closeBtn
{
    [selectNumberView removeFromSuperview];
    NSDictionary *monthDic = [self.calendarDataCenter.dataArray objectAtIndex:self.selectedIndexPath.section];
    NSMutableArray *weekArray = [[monthDic allValues] objectAtIndex:0];
    [weekArray removeObjectAtIndex:self.selectedIndexPath.row-2];
    [self.tableView deleteRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationTop];
}

@end
