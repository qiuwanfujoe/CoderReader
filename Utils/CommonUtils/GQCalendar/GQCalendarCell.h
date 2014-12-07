//
//  GQCalendarCell.h
//  CodeReader
//
//  Created by Gideon on 11/2/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQDateButton.h"
@class GQCalendarCell;

@protocol GQCalendarCelldelegate <NSObject>
- (void)calendarcell:(GQCalendarCell *)calendarCell dayBtnClicked:(GQDateButton *)button;

@end

@interface GQCalendarCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<GQCalendarCelldelegate> delegate;
- (void)setDayButtonWithWeekArray:(NSArray *)weekArray;

@end
