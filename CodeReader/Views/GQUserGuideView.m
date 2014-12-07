//
//  GQUserGuideView.m
//  CodeReader
//
//  Created by Gideon on 8/3/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "GQUserGuideView.h"
@interface GQUserGuideView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation GQUserGuideView

- (void)awakeFromNib
{
    NSArray *images = @[@"guide1.png", @"guide2.png"];
    NSInteger count = 0;
    for (NSString *imageName in images) {
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(count * self.scrollView.frame.size.width, 0, 320, 400);
        count++;
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(images.count * self.scrollView.frame.size.width, 400);
    self.pageControl.numberOfPages = images.count;
}

- (IBAction)pageControlTaped:(id)sender
{
    [self.scrollView setContentOffset:CGPointMake(_pageControl.currentPage * self.scrollView.frame.size.width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.scrollView.contentOffset.x / 320;
}

@end
