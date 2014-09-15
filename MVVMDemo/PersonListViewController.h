//
//  PersonListViewController.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXGroup+LocalDataService.h"

@interface PersonListViewController : UIViewController
@property (nonatomic, strong) CXGroup* group;
@end
