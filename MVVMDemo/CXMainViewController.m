//
//  ViewController.m
//  MVVMDemo
//
//  Created by qiufu on 12/4/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import "CXMainViewController.h"
#import <Masonry/Masonry.h>
#import "CXMovieTableViewCell.h"
#import "CXMovieService.h"

NSString *const CXMovieCellIdentifier = @"CXMovieCellIdentifier";

@interface CXMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation CXMainViewController

#pragma mark - Property
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_myTableView registerClass:[CXMovieTableViewCell class] forCellReuseIdentifier:CXMovieCellIdentifier];
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
    }
    
    return _myTableView;
}


#pragma mark - Lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel = [[CXMainViewModel alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Load data.
    [self loadData];
    
    // Setup ui.
    [self setupUI];
}


#pragma mark - Setup
- (void)loadData {
    
    // Refresh data.
    [self refresh:nil];
    
}

- (void)setupUI {
    // Use full screen layout.
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // Navigation title.
    self.navigationItem.title = [self.viewModel navigationTitleText];
    
    // Navigation item.
    UIBarButtonItem *billListBarButtom = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = billListBarButtom;

    
    // Setup myTableView.
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Subcribe data updated signal to bind view model and view.
    @weakify(self);
    [self.viewModel.dataUpdatedSignal subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"Next");
        NSLog(@"%@", x);
        if ([x isEqualToString:@"movieList"]) {
            [self.myTableView reloadData];
        }
        else if ([x isEqualToString:@"categoryTitle"]) {
            self.navigationItem.title = [self.viewModel navigationTitleText];
        }
        else if ([x isEqualToString:@"all"]) {
            [self.myTableView reloadData];
            self.navigationItem.title = [self.viewModel navigationTitleText];
        }
    }];
    [self.viewModel.errorSignal subscribeNext:^(id x) {
        NSLog(@"Error");
    }];

    

}


#pragma mark - Action
- (void)refresh:(id)sender {
    // Send refresh data action.
    [self.viewModel refreshViewDataWithParameters:@{@"para1":@"value1", @"para2":@"value2"}];
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CXMovieTableViewCell heightForModel:nil atIndexPath:indexPath];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel movieCellCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CXMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CXMovieCellIdentifier forIndexPath:indexPath];
    
    CXMovieCellViewModel *cellViewModel = [self.viewModel movieCellViewModelAtIndexPath:indexPath];
    cell.viewModel = cellViewModel;
    
    return cell;
}


@end

