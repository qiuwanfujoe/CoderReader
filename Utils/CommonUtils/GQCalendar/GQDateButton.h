//
//  GQDateButton.h
//  CodeReader
//
//  Created by Gideon on 10/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCalendarDayTitleHighlightedColor [UIColor whiteColor]
#define kCalendarDayTitleDisableColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]
typedef enum {
    eGQDateButtonStateDisable=0,	/** 置灰状态 */
    eGQDateButtonStateNormal,	/** 普通状态 */
    eCTCalendarDayButtonStateSelected,	/** 选中状态 */
    eGQDateButtonStateSelectedForGo,	/** 出发选中状态 */
    eGQDateButtonStateSelectedForBack,	/** 返回选中状态 */
    eGQDateButtonStateSelectedForGoAndBack,	/** 往返选中状态 */
    eGQDateButtonStateSelectedForCheckIn,	/** 入住选中状态 */
    eGQDateButtonStateSelectedForCheckOut,	/** 离店选中状态 */
    eGQDateButtonStateHighlighted	/** 高亮状态 */
} eGQDateButtonState;

@interface GQDateButton : UIButton{
@protected
    CGRect titleOriginFrame_;
    CGRect tipOriginFrame_;
    CGRect titleSelectedFrame_;
    CGRect tipSelectedFrame_;
    int showState_;
    
    UILabel *titleLabel_;
    UILabel *tipLabel_;
}


/**	标题label */
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
/**	子标题label */
@property (nonatomic, strong) IBOutlet UILabel *tipLabel;
/**	显示状态 */
@property (nonatomic, assign) int showState;

/**
	设置标题
	@param titleString 标题字符串
 */
- (void)setTitle:(NSString *)titleString;
/**
	设置子标题
	@param tipString 子标题字符串
 */
- (void)setTip:(NSString *)tipString;
/**
	初始化视图
 */
- (void)initBaseView;
@end
