//
//  GroupListViewModel.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXGroupListViewModel.h"
#import "CXGroup+LocalDataService.h"

@interface CXGroupListViewModel ()
@property (nonatomic, strong) NSArray* groups;
@end

@implementation CXGroupListViewModel

#pragma mark - Property
-(NSInteger) numberOfGroups {
    return [self.groups count];
}

#pragma mark - Init
-(instancetype) init {
    self = [super init];
    if (self) {
        self.groups = [CXGroup getGroupList];
    }
    
    return self;
}

#pragma mark - Public Method
-(CXGroup*) groupAtIndex:(NSInteger)index {
    return [self.groups objectAtIndex:index];
}

-(NSString*) titleForGroupAtIndex:(NSInteger)index {
    return [[self groupAtIndex:index] groupName];
}

-(NSString*) subtitleForGroupAtIndex:(NSInteger)index {
    return [[self groupAtIndex:index] groupDescription];
}


@end
