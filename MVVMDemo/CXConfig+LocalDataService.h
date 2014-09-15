//
//  CXConfig+LocalDataService.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXConfig.h"

@interface CXConfig (LocalDataService)

// Local Data Service
+(CXConfig*) getConfigWithKey:(NSString*)key;
+(int32_t) addConfig:(CXConfig*)c;
+(BOOL) updateConfig:(CXConfig*)c;

@end
