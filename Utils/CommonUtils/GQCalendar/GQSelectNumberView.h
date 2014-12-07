//
//  GQSelectNumberView.h
//  CodeReader
//
//  Created by Gideon on 11/8/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GQSelectNumberView;

@protocol GQSelectNumberViewDelegate <NSObject>
- (void)selectNumberView:(GQSelectNumberView *)selectNumberView selectNumber:(NSInteger)number;
- (void)selectNumberView:(GQSelectNumberView *)selectNumberView close:(UIButton *)closeBtn;
@end

@interface GQSelectNumberView : UIView
@property (nonatomic, weak) id<GQSelectNumberViewDelegate> delegate;
@end
