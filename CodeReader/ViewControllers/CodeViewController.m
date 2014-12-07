//
//  CodeViewController.m
//  CodeReader
//
//  Created by Gideon on 7/12/14.
//  Copyright (c) 2014 GN. All rights reserved.
//

#import "CodeViewController.h"
#import "CodeDisplayViewController.h"
#import "GQUploadViewController.h"
#import "GQFolderUtil.h"
#import "GQRootFolder.h"
#import "GQFile.h"
#import "GQBaseCell.h"
#import "GQFolderCell.h"
#import "GQFileCell.h"
#import "GQUserGuideView.h"
#import "GQDeviceutil.h"
#import "GQCalendarView.h"

@interface CodeViewController ()<UITableViewDelegate, UITableViewDataSource, GQFolderCellDelegate, GQFileCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *projects;
@property (strong, nonatomic) GQRootFolder *rootFolder;

@property (strong, nonatomic) GQUserGuideView *guideView;
@property (strong, nonatomic) GQCalendarView *calendarView;

@end

@implementation CodeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DidUploadFiles" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initBaseView];
    [self registerNotifications];
    self.projects = [NSMutableArray array];
    [self readFolder];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.rootFolder forKey:@"folder"];
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSKeyedArchiver archivedDataWithRootObject:dict] forKey:@"userinfo"];
    
    NSData *loginInfoData = [userDefault dataForKey:@"userinfo"];
    NSDictionary *loginInfoDict = [NSKeyedUnarchiver unarchiveObjectWithData:loginInfoData];
}

- (void)initBaseView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 26, 26);
    [button setBackgroundImage:[UIImage imageNamed:@"user_guide"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showUserGuide) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showUploadPage)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUploadFiles) name:@"DidUploadFiles" object:nil];
}

- (void)showUploadPage
{
    GQUploadViewController *uploadVC = [[GQUploadViewController alloc] init];
    [self.navigationController pushViewController:uploadVC animated:YES];
}

- (void)didUploadFiles
{
    [self.projects removeAllObjects];
    [self readFolder];
    [self.tableView reloadData];
}

- (void)showUserGuide
{
    [self testCalendarView];//仅仅是测试日历控件，可删除
    return;
    _guideView.hidden = !_guideView.hidden;
    if (!self.guideView) {
        _guideView= [[[NSBundle mainBundle] loadNibNamed:@"GQUserGuideView" owner:self options:nil] firstObject];
        if ([GQDeviceutil isSystemVersionLarger:7.0]) {
            _guideView.viewOriginY = 64;
        } else {
            _guideView.viewOriginY = 44;
        }
        [self.view addSubview:_guideView];
    }
}

- (void) hideUserGuide
{
    _guideView.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.projects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *folderIndenty = @"GQFolderCell";
    static NSString *fileIndenty = @"GQFileCell";
    id clsObj = [self.projects objectAtIndex:indexPath.row];
    if ([clsObj isKindOfClass:[GQFolder class]]) {
        GQFolder *folder = clsObj;
        GQFolderCell *folderCell = [tableView dequeueReusableCellWithIdentifier:folderIndenty];
        if (!folderCell) {
            folderCell = [[[NSBundle mainBundle] loadNibNamed:folderIndenty owner:self options:nil] objectAtIndex:0];
        }
        folderCell.delegate = self;
        [folderCell loadContent:folder];
        return folderCell;
    } else if ([clsObj isKindOfClass:[GQFile class]]) {
        GQFile *file = clsObj;
        GQFileCell *fileCell = [tableView dequeueReusableCellWithIdentifier:fileIndenty];
        if (!fileCell) {
            fileCell = [[[NSBundle mainBundle] loadNibNamed:fileIndenty owner:self options:nil] objectAtIndex:0];
        }
        fileCell.delegate = self;
        [fileCell loadContent:file];
        return fileCell;
    }
    return nil;
}

- (void)showCode:(NSString *)filePath
{
    CodeDisplayViewController *codeDisplayVC = [[CodeDisplayViewController alloc] initWithNibName:@"CodeDisplayViewController" bundle:nil];
    codeDisplayVC.filePath = filePath;
    [self.navigationController pushViewController:codeDisplayVC animated:YES];
}

- (void)readFolder
{
    self.rootFolder = [[GQRootFolder alloc] initWithRootPath:kDocumentDir];
    
    [self.projects addObjectsFromArray:self.rootFolder.subFolders];
    [self.projects addObjectsFromArray:self.rootFolder.files];
}

- (NSIndexPath *)indexPathWithObject:(id)obj
{
    NSInteger row = [self.projects indexOfObject:obj];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    return indexPath;
}

#pragma mark -cell delegate
- (void)showFolderContent:(GQFolderCell *)folderCell
{
    GQFolder *folder = folderCell.folder;
    NSInteger row = [self.projects indexOfObject:folder];
    
    for (GQFile *subFile in folder.files) {
        [self.projects insertObject:subFile atIndex:++row];
        NSIndexPath *subFileIndexPath = [self indexPathWithObject:subFile];
        [self.tableView insertRowsAtIndexPaths:@[subFileIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        subFile.isShowing = YES;
    }
    
    for (GQFolder *subFodler in folder.subFolders) {
        [self.projects insertObject:subFodler atIndex:++row];
        NSIndexPath *subFolderIndexPath = [self indexPathWithObject:subFodler];
        [self.tableView insertRowsAtIndexPaths:@[subFolderIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        subFodler.isShowing = YES;
    }
}

- (void)hideFolderContent:(GQFolderCell *)folderCell
{
    GQFolder *folder = folderCell.folder;
    NSArray *fileArray = [GQFolderUtil getAllFilesInFolder:folder];
    for (id file in fileArray) {
        [self deleteFile:file];
    }
}

- (void)deleteFile:(id)file
{
    NSIndexPath *subFileIndexPath = [self indexPathWithObject:file];
    [self.projects removeObject:file];
    if ([file isKindOfClass:[GQFolder class]]) {
        GQFolder *folder = file;
        folder.isShowing = NO;
        folder.isShowSubFolder = NO;
    } else if ([file isKindOfClass:[GQFile class]]) {
        GQFile *tempFile = file;
        tempFile.isShowing = NO;
    }
//    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[subFileIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
//    [self.tableView endUpdates];
}

- (void)showFileContent:(GQFileCell *)fileCell
{
    [self showCode:fileCell.file.filePath];
}

//
- (void)testCalendarView
{
    if (!self.calendarView) {
        self.calendarView = [[[NSBundle mainBundle] loadNibNamed:@"GQCalendarView" owner:self options:nil] objectAtIndex:0];
    } else {
        self.calendarView.hidden = !self.calendarView.hidden;
        return;
    }
    self.calendarView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _calendarView.viewHeight, _calendarView.viewWidth, _calendarView.viewHeight);
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2014;
    components.month = 11;
    components.day = 1;
    
    NSDateComponents *components2 = [[NSDateComponents alloc] init];
    components2.year = 2015;
    components2.month = 4;
    components2.day = 30;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateFromComponents:components2];
    
    [_calendarView prepareWithStartDate:startDate endDate:endDate currentDate:[NSDate date]];
    [self.view addSubview:_calendarView];
}

@end
