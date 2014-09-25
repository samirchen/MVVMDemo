//
//  CXGroupEditViewModel.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-20.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXGroupEditViewModel.h"
#import "CXGroup+LocalDataService.h"

@interface CXGroupEditViewModel ()
@property (nonatomic, strong) CXGroup* group;
@property (nonatomic, strong) NSString* nameString;
@property (nonatomic, strong) NSString* descriptionString;
@end

@implementation CXGroupEditViewModel

#pragma mark - Init
-(instancetype) initWithGroup:(CXGroup *)g {
    self = [super init];
    if (self) {
        self.group = g;
        if (g) {
            self.nameString = g.groupName;
            self.descriptionString = g.groupDescription;
        }
        else {
            self.nameString = @"";
            self.descriptionString = @"";
        }
    }
    
    return self;
}

@end
