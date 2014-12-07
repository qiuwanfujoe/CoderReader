//
//  GQDateButton.m
//  CodeReader
//
//  Created by Gideon on 10/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQDateButton.h"

@implementation GQDateButton


@synthesize titleLabel = titleLabel_;
@synthesize tipLabel = tipLabel_;
@synthesize showState = showState_;
#pragma mark - --------------------退出清空--------------------

#pragma mark - --------------------初始化--------------------

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [self initBaseView];
}

#pragma mark 初始化视图
- (void)initBaseView
{
    [self setBackgroundImage:[UIImage imageNamed:@"CTCAlendarView_Button_Pressed_Background.png"] forState:UIControlStateHighlighted];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    
    titleOriginFrame_ = self.bounds;
    tipOriginFrame_ = CGRectMake(0, self.bounds.size.height/2.0, self.bounds.size.width, self.bounds.size.height/2.0);
    titleSelectedFrame_ = CGRectMake(0, -8, self.bounds.size.width, self.bounds.size.height);
    tipSelectedFrame_ = tipOriginFrame_;
    
    if (!titleLabel_) {
        titleLabel_ = [[UILabel alloc] initWithFrame:titleOriginFrame_];
        [titleLabel_ setFont:[UIFont systemFontOfSize:15]];
        [titleLabel_ setAdjustsFontSizeToFitWidth:YES];
//        [titleLabel_ setMinimumFontSize:10];
        [titleLabel_ setTextAlignment:NSTextAlignmentCenter];
        [titleLabel_ setBackgroundColor:[UIColor clearColor]];
        [self addSubview:titleLabel_];
    }
    if (!tipLabel_) {
        tipLabel_ = [[UILabel alloc] initWithFrame:tipOriginFrame_];
        [tipLabel_ setFont:[UIFont systemFontOfSize:11]];
        [tipLabel_ setTextColor:[UIColor whiteColor]];
        [tipLabel_ setTextAlignment:NSTextAlignmentCenter];
        [tipLabel_ setBackgroundColor:[UIColor clearColor]];
        [self addSubview:tipLabel_];
    }
}
#pragma mark - --------------------属性相关--------------------
#pragma mark 设置frame
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
#pragma mark 设置显示状态
- (void)setShowState:(int)showState
{
    showState_ = showState;
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    titleLabel_.font = [UIFont systemFontOfSize:15];
    
    UIColor *startDateColor = [UIColor colorWithRed:0x14/255.0 green:0x91/255.0f blue:0xc5/255.0f alpha:1.0f];
    UIColor *endDateColor = [UIColor colorWithRed:0x9d/255.0 green:0xbb/255.0f blue:0xcd/255.0f alpha:1.0f];
    
    
    switch (showState_) {
        case eGQDateButtonStateNormal:
        {
            [self setEnabled:YES];
            [self setBackgroundImage:nil forState:UIControlStateNormal];
            [tipLabel_ setHidden:YES];
            [titleLabel_ setFrame:titleOriginFrame_];
        }
            break;
            
        case eGQDateButtonStateDisable:
        {
            [self setEnabled:NO];
            [self setBackgroundImage:nil forState:UIControlStateNormal];
            [tipLabel_ setHidden:YES];
            [titleLabel_ setFrame:titleOriginFrame_];
            [titleLabel_ setTextColor:kCalendarDayTitleDisableColor];
            
        }
            break;
        case eGQDateButtonStateHighlighted:
        {
            [self setEnabled:YES];
            [self setBackgroundColor:[UIColor colorWithRed:0xee/255.0 green:0xf6/255.0 blue:0xf9/255.0f alpha:1.0f]];
            [tipLabel_ setHidden:YES];
            titleLabel_.textColor = [UIColor colorWithWhite:0 alpha:0.8f];
            [titleLabel_ setFrame:titleOriginFrame_];
        }
            break;
        case eCTCalendarDayButtonStateSelected:
        {
            [self setEnabled:YES];
            [self setBackgroundColor:[UIColor colorWithRed:0x14/255.0 green:0x91/255.0f blue:0xc5/255.0f alpha:1.0f]];
            [tipLabel_ setHidden:YES];
            [titleLabel_ setFrame:titleOriginFrame_];
            [titleLabel_ setTextColor:kCalendarDayTitleHighlightedColor];
        }
            break;
        case eGQDateButtonStateSelectedForGo:
        {
            [self setEnabled:YES];
            [self setBackgroundColor:startDateColor];
            [tipLabel_ setHidden:NO];
//            [tipLabel_ setText:kCalendarTipGo];
            titleLabel_.font = [UIFont systemFontOfSize:13];
            titleLabel_.textColor = [UIColor colorWithWhite:0xff/255.0f alpha:1.0f];
            [titleLabel_ setFrame:titleSelectedFrame_];
            [titleLabel_ setTextColor:kCalendarDayTitleHighlightedColor];
        }
            break;
        case eGQDateButtonStateSelectedForBack:
        {
            [self setEnabled:YES];
            [self setBackgroundColor:endDateColor];
            [tipLabel_ setHidden:NO];
            titleLabel_.font = [UIFont systemFontOfSize:13];
            titleLabel_.textColor = [UIColor colorWithWhite:0xff/255.0f alpha:1.0f];
//            [tipLabel_ setText:kCalendarTipBack];
            [titleLabel_ setFrame:titleSelectedFrame_];
            [titleLabel_ setTextColor:kCalendarDayTitleHighlightedColor];
        }
            break;
        case eGQDateButtonStateSelectedForGoAndBack:
        {
            [self setEnabled:YES];
            [self setBackgroundColor:startDateColor];
            [tipLabel_ setHidden:NO];
//            [tipLabel_ setText:kCalendarTipGoAndBack];
            [titleLabel_ setFrame:titleSelectedFrame_];
            [titleLabel_ setTextColor:kCalendarDayTitleHighlightedColor];
            
        }
            break;
        case eGQDateButtonStateSelectedForCheckIn:
        {
            [self setEnabled:YES];
            [self setBackgroundColor:startDateColor];
            [tipLabel_ setHidden:NO];
//            [tipLabel_ setText:kCalendarTipCheckIn];
            [titleLabel_ setFrame:titleSelectedFrame_];
            [titleLabel_ setTextColor:kCalendarDayTitleHighlightedColor];
        }
            break;
        case eGQDateButtonStateSelectedForCheckOut:
        {
            [self setEnabled:YES];
            [self setBackgroundColor:endDateColor];
            [tipLabel_ setHidden:NO];
//            [tipLabel_ setText:kCalendarTipCheckOut];
            [titleLabel_ setFrame:titleSelectedFrame_];
            [titleLabel_ setTextColor:kCalendarDayTitleHighlightedColor];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - --------------------接口API--------------------
#pragma mark 设置标题
- (void)setTitle:(NSString *)titleString
{
    if (titleLabel_) {
        [titleLabel_ setText:titleString];
    }
}
#pragma mark 设置子标题
- (void)setTip:(NSString *)tipString
{
    if (tipLabel_) {
        [tipLabel_ setText:tipString];
    }
}

#pragma mark 设置高亮
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

#pragma mark 设置选中
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
}


@end
