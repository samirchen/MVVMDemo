//
//  CXPerson+LocalDataService.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXPerson.h"

@interface CXPerson (LocalDataService)

// Local Data Service
+(NSArray*) getPersonListWithGroupId:(int32_t)groupId;
+(int32_t) addPerson:(CXPerson*)p;
+(BOOL) updatePerson:(CXPerson*)p;
+(BOOL) removePerson:(CXPerson*)p;


@end
