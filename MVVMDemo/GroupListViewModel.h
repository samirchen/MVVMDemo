//
//  GroupListViewModel.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXGroup;

@interface GroupListViewModel : NSObject

@property (nonatomic, readonly) NSArray* groups;
@property (nonatomic) NSInteger numberOfGroups;

-(CXGroup*) groupAtIndex:(NSInteger)index;
-(NSString*) titleForGroupAtIndex:(NSInteger)index;
-(NSString*) subtitleForGroupAtIndex:(NSInteger)index;

@end
