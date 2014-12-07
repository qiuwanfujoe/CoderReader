//
//  GQUploadViewController.m
//  CodeReader
//
//  Created by Gideon on 8/2/14.
//  Copyright (c) 2014 GN. All rights reserved.
//
// Log levels: off, error, warn, info, verbose

#import "GQUploadViewController.h"
#import "HttpUtil.h"
#import "AppDelegate.h"
#import "GQUploadFileCell.h"
#import "CodeDisplayViewController.h"
#import "GQFolderUtil.h"

@interface GQUploadViewController () <UITableViewDelegate, UITableViewDataSource, GQUploadFileCellDelegate>
@property (nonatomic, weak) IBOutlet UILabel *ipAddressLabel;
@property (nonatomic, weak) IBOutlet UILabel *wifiNameLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIProgressView *uploadProgress;

@property (nonatomic, strong) NSMutableArray *uploadFiles;
@end

@implementation GQUploadViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initBaseData];
    [self initBaseView];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[AppDelegate shareAppDelegate] startServer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[AppDelegate shareAppDelegate] stopServer];
    [super viewWillDisappear:animated];
}

- (void)initBaseData
{
    if (!self.uploadFiles) {
        self.uploadFiles = [NSMutableArray array];
    }
     self.uploadProgress.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fileUploded:) name:@"DidUploadFiles" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginFileUplod) name:@"BeginUploadFiles" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadingFile:) name:@"UploadingFiles" object:nil];
}

- (void)initBaseView
{
    self.ipAddressLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.ipAddressLabel.layer.borderWidth = 1.f;
    self.ipAddressLabel.text = [NSString stringWithFormat:@"http://%@:%d", [HttpUtil localWiFiIPAddress], ip_port];
    
    self.wifiNameLabel.text = [HttpUtil getWifiName];
}

- (void)fileUploded:(NSNotification *)notification
{
    self.uploadProgress.hidden = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    NSArray *newUploadedFiles = [userInfo objectForKey:@"uploadedFiles"];
    [self.uploadFiles addObjectsFromArray:newUploadedFiles];
    [self.tableView reloadData];
}

- (void)beginFileUplod
{
    self.uploadProgress.hidden = NO;
}

- (void)uploadingFile:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    float percent = [[userInfo objectForKey:@"upload_progress"] floatValue];
    self.uploadProgress.progress = percent;
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.uploadFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIndentify = @"GQUploadFileCell";
    GQUploadFileCell *fileCell = [tableView dequeueReusableCellWithIdentifier:tableCellIndentify];
    if (!fileCell) {
        fileCell = [[[NSBundle mainBundle] loadNibNamed:@"GQUploadFileCell" owner:self options:nil] objectAtIndex:0];
        fileCell.delegate = self;
    }
    [fileCell loadUploadFileCell:[self.uploadFiles objectAtIndex:indexPath.row]];
    return fileCell;
}

#pragma mark - FileCellDelegate
- (void)showFileContent:(GQUploadFileCell *)fileCell
{
    CodeDisplayViewController *codeVC = [[CodeDisplayViewController alloc] init];
    codeVC.filePath = [kDocumentDir stringByAppendingPathComponent:fileCell.filePath];
    [self.navigationController pushViewController:codeVC animated:YES];
}

@end
