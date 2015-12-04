//
//  ViewController.m
//  MVVMDemo
//
//  Created by qiufu on 12/4/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import "CXMainViewController.h"

NSString *const CellIdentifier = @"CellIdentifier";

@interface CXMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation CXMainViewController

#pragma mark - Property
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
    }
    
    return _myTableView;
}


#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}


#pragma mark - Setup
- (void)setupUI {
    // Use full screen layout.
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // Set navigation title.
    self.navigationItem.title = @"MVVM Demo";
    
    
    
    // Setup myTableView.
    [self.view addSubview:self.myTableView];
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"Hi";
    
    return cell;
}


@end

