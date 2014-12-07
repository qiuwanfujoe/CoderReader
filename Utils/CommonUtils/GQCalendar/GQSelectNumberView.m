//
//  GQSelectNumberView.m
//  CodeReader
//
//  Created by Gideon on 11/8/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQSelectNumberView.h"

@interface GQSelectNumberView() <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
@implementation GQSelectNumberView
- (void)awakeFromNib
{
    [self initView];
}

- (void)initView
{
    for (int i = 0; i < 28; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(i*60, 0, 60, self.scrollView.frame.size.height);
        button.titleLabel.textColor = [UIColor redColor];
        button.backgroundColor = [UIColor blueColor];
        button.tag = i+ 1;
        [button setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(numberTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
    }
    self.scrollView.contentSize = CGSizeMake(28*60, self.scrollView.frame.size.height);
    self.scrollView.delegate = self;
}

- (void)numberTapped:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(selectNumberView:selectNumber:)]) {
        [self.delegate selectNumberView:self selectNumber:button.tag];
    }
}

- (IBAction)close:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectNumberView:close:)]) {
        [self.delegate selectNumberView:self close:sender];
    }
}

@end
