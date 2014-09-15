//
//  ViewController.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "GroupListViewController.h"
#import "CXConst.h"
#import "CXGroup+LocalDataService.h"
#import "PersonListViewController.h"

#define SegueIDToPersonListViewController @"ToPersonListViewController"

@interface GroupListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *dataTableView;
@end

@implementation GroupListViewController

#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.model = [[GroupListViewModel alloc] init];
    
    // Setup.
    [self setupUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueIDToPersonListViewController]) {
        PersonListViewController* vc = (PersonListViewController*) segue.destinationViewController;
        vc.group = [self.model groupAtIndex:self.dataTableView.indexPathForSelectedRow.row];
    }
}

#pragma mark - Action
-(void) setupUI {
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Table view.
    self.dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-44) style:UITableViewStylePlain];
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
    
    
}



#pragma mark - UITableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:SegueIDToPersonListViewController sender:tableView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.numberOfGroups;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"GroupCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    // Configure the cell.
    cell.textLabel.text = [self.model titleForGroupAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.model subtitleForGroupAtIndex:indexPath.row];
    
    
    return cell;
}


@end
