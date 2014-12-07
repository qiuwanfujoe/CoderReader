//
//  GQCalendarCell.m
//  CodeReader
//
//  Created by Gideon on 11/2/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQCalendarCell.h"
#import "GQCalendarDataModel.h"

@interface GQCalendarCell()
@property (weak, nonatomic) IBOutlet GQDateButton *sundayBtn;
@property (weak, nonatomic) IBOutlet GQDateButton *mondayBtn;
@property (weak, nonatomic) IBOutlet GQDateButton *tuesdayBtn;
@property (weak, nonatomic) IBOutlet GQDateButton *wednesdayBtn;
@property (weak, nonatomic) IBOutlet GQDateButton *thursdayBtn;
@property (weak, nonatomic) IBOutlet GQDateButton *fridayBtn;
@property (weak, nonatomic) IBOutlet GQDateButton *saturdayBtn;

@end

@implementation GQCalendarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDayButtonWithWeekArray:(NSArray *)weekArray
{
    if (weekArray.count <= 0) {
        return;//need to define
    }
    for (int i = 0; i < 7; i++) {
        GQCalendarDataModel *dataModel = [weekArray objectAtIndex:i];
        GQDateButton *dayButton = [self getDayButtonWithIndex:i];
        if ([NSNull null] == (id)dataModel) {
            [dayButton setTitle:nil forState:UIControlStateNormal];
        } else {
            dayButton.hidden = NO;
            [dayButton setTitle:[NSString stringWithFormat:@"%d", (int)dataModel.day] forState:UIControlStateNormal];
            dayButton.showState = (int)dataModel.state;
        }
    }
}

- (GQDateButton *)getDayButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return self.sundayBtn;
            break;
        case 1:
            return self.mondayBtn;
            break;
        case 2:
            return self.tuesdayBtn;
            break;
        case 3:
            return self.wednesdayBtn;
            break;
        case 4:
            return self.thursdayBtn;
            break;
        case 5:
            return self.fridayBtn;
            break;
        case 6:
            return self.saturdayBtn;
            break;
            
        default:
            return nil;
            break;
    }
}

- (IBAction)dayBtnTapped:(id)sender {
    @synchronized(self) {
        if ([self.delegate respondsToSelector:@selector(calendarcell:dayBtnClicked:)]) {
            [self.delegate calendarcell:self dayBtnClicked:sender];
        }
    }
}

@end
