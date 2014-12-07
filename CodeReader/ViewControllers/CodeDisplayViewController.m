//
//  CodeDisplayViewController.m
//  CodeReader
//
//  Created by Gideon on 7/26/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "CodeDisplayViewController.h"
#import "FileReader.h"
#import "UIView+Helper.h"
#import "NSString+CTExtensions.h"
#import "GQRegUtil.h"
#import "GQAppConstant.h"

@interface CodeDisplayViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) id fileContent;

@end

@implementation CodeDisplayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadContentWithFilePath:self.filePath];
}

- (void)loadContentWithFilePath:(NSString *)filePath
{
    if ([[[filePath pathExtension] lowercaseString] isEqualToString:@"pdf"]) {
        [self loadPDFDocByPath:filePath];
        return;
    }
    self.fileContent = [FileReader loadHTMLContent:filePath];
    if ([self.fileContent isKindOfClass:[NSString class]]) {
        if (![GQRegUtil isValidFileExtention:filePath]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"GQ.File.Warning.extention.incorrect")
                                                            message:LocalizedString(@"GQ.File.Warning.extention.try")
                                                           delegate:nil
                                                  cancelButtonTitle:LocalizedString(@"OK")
                                                  otherButtonTitles:nil];
            [alert show];
            [self.indicatorView stopAnimating];
            return ;
        }
        NSURL *baseURl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        [self.webView loadHTMLString:_fileContent baseURL:baseURl];
    } else if ([self.fileContent isKindOfClass:[UIImage class]]) {
        UIImage *image = self.fileContent;
        if (image.size.width > [self.view viewWidth]) {
            self.imageView.viewWidth = self.view.viewWidth;
        } else {
            self.imageView.viewWidth = image.size.width;
        }
        if (image.size.height > [self.view viewHeight]) {
            self.imageView.viewHeight = self.view.viewHeight;
        } else {
            self.imageView.viewHeight = image.size.height;
        }
        self.imageView.center = self.view.center;
        self.imageView.image = image;
        [self.indicatorView stopAnimating];
    }
}

- (void)loadPDFDocByPath:(NSString *)filePath
{
    //加载本地pdf到webview
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicatorView stopAnimating];
}

@end
