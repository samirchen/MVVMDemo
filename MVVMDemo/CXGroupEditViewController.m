//
//  CXGroupEditViewController.m
//  MVVMDemo
//
//  Created by SamirChen on 9/19/14.
//  Copyright (c) 2014 cx. All rights reserved.
//

#import "CXGroupEditViewController.h"
#import "CXConst.h"
#import "CXGroup+LocalDataService.h"
#import "CXCommonUICreator.h"
#import <ReactiveCocoa.h>
#import "CXGroupEditViewModel.h"
#import "CXPersonListViewController.h"

#define SegueIDToPersonListViewController @"ToPersonListViewController"

typedef NS_ENUM(NSInteger, GroupEditRowType) {
    GroupEditRowTypeGroupName = 0,
    GroupEditRowTypeGroupDescription,
    GroupEditRowTypeCount
};

@interface CXGroupEditViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) UITableView *dataTableView;
@property (strong, nonatomic) UITextField *groupNameTextField;
@property (strong, nonatomic) UITextField *groupDescriptionTextField;
@property (strong, nonatomic) UIButton* submitButton;
@end

@implementation CXGroupEditViewController

#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Setup.
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Dismiss keyboard.
    [self.groupNameTextField resignFirstResponder];
    [self.groupDescriptionTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - View Controller Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - View Controller Navigation
-(void) back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueIDToPersonListViewController]) {
        CXPersonListViewController* vc = (CXPersonListViewController*) segue.destinationViewController;
        vc.model = [[CXPersonListViewModel alloc] initWithGroup:self.model.group];
    }
}

#pragma mark - Setup
-(void) setupUI {
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Table view.
    self.dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-44) style:UITableViewStyleGrouped];
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
    
    // Footer view.
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    self.submitButton = [CXCommonUICreator buttonWithFrame:CGRectMake(20, 0, ScreenWidth-20*2, 40) bgColor:[UIColor redColor] bgTouchColor:[UIColor grayColor] bgDisableColor:[UIColor colorWithWhite:0.5 alpha:0.5] title:@"Submit" titleColor:[UIColor whiteColor] titleTouchColor:[UIColor whiteColor] target:self andAction:@selector(submit:)];
    [footerView addSubview:self.submitButton];
    self.dataTableView.tableFooterView = footerView;
    
    // Cell text fields.
    self.groupNameTextField = [CXCommonUICreator textFieldWithRoundedRectBorderWithFrame:CGRectMake(0, 0, 230, 30) placeholder:@"Group Name" keyboardType:UIKeyboardTypeEmailAddress returnKeyType:UIReturnKeyNext];
    self.groupNameTextField.delegate = self;
    
    self.groupDescriptionTextField = [CXCommonUICreator textFieldWithRoundedRectBorderWithFrame:CGRectMake(0, 0, 230, 30) placeholder:@"Group Description" keyboardType:UIKeyboardTypeEmailAddress returnKeyType:UIReturnKeyNext];
    self.groupDescriptionTextField.delegate = self;
    
    if (!self.model.group) { // When add new group.
        // Bind self.submitButton.enabled to the text fields' string value.
        RAC(self.submitButton, enabled) = [RACSignal combineLatest:@[self.groupNameTextField.rac_textSignal, self.groupDescriptionTextField.rac_textSignal] reduce:^id(NSString *name, NSString *desc) {
            return @(![[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] && ![[desc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]);
        }];
    }
    
    
    self.groupNameTextField.text = self.model.nameString;
    self.groupDescriptionTextField.text = self.model.descriptionString;
    
}


#pragma mark - User Action
-(void) submit:(id)sender {
    if (self.model.group) {
        self.model.group.groupName = self.groupNameTextField.text;
        self.model.group.groupDescription = self.groupDescriptionTextField.text;
        [CXGroup updateGroup:self.model.group];
    }
    else {
        CXGroup* newGroup = [[CXGroup alloc] initWithName:self.groupNameTextField.text description:self.groupDescriptionTextField.text];
        [CXGroup addGroup:newGroup];
    }
    
    [self back:nil];
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
    return GroupEditRowTypeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"GroupEditCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    
    // Configure the cell.
    switch (indexPath.row) {
        case GroupEditRowTypeGroupName:
        {
            cell.accessoryView = self.groupNameTextField;
            [cell.textLabel setText:@"Name"];
            break;
        }
            
            
        case GroupEditRowTypeGroupDescription:
        {
            cell.accessoryView = self.groupDescriptionTextField;
            [cell.textLabel setText:@"Desc"];
            break;
        }
            
        default:
            break;
    }
    
    
    return cell;
}


#pragma mark - UITextField Delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.groupNameTextField) {
        [self.groupNameTextField resignFirstResponder];
        [self.groupDescriptionTextField becomeFirstResponder];
    }
    else if (textField == self.groupDescriptionTextField) {
        [self.groupDescriptionTextField resignFirstResponder];
        [self submit:nil];
    }
    
    return YES;
}

@end
