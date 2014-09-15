//
//  PersonListViewController.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "PersonListViewController.h"
#import "CXConst.h"
#import "CXPerson+LocalDataService.h"

@interface PersonListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *dataTableView;
@property (strong, nonatomic) NSArray* persons;
@end

@implementation PersonListViewController

#pragma mark - View Controller Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Setup.
    [self setupUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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

-(void) loadData {
    self.persons = [CXPerson getPersonListWithGroupId:self.group.rowid];
}

#pragma mark - UITableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"GroupCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    // Configure the cell.
    CXPerson* p = self.persons[indexPath.row];
    cell.textLabel.text = p.personName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Gender: %d", p.gender];
    
    
    return cell;
}





@end
