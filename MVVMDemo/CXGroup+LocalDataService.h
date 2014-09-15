//
//  CXGroup+LocalDataService.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXGroup.h"

@interface CXGroup (LocalDataService)

// Local Data Service
+(NSArray*) getGroupList;
+(CXGroup*) getGroupWithId:(int32_t)gid;
+(int32_t) addGroup:(CXGroup*)g;
+(BOOL) updateGroup:(CXGroup*)g;
+(BOOL) removeGroup:(CXGroup*)g;

@end
