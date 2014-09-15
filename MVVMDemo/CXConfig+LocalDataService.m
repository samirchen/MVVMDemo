//
//  CXConfig+LocalDataService.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXConfig+LocalDataService.h"
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import "CXDBConst.h"
#import "CXDBManager.h"

@implementation CXConfig (LocalDataService)

#pragma mark - Utility
+(id) getObjectFromResultSet:(FMResultSet*)rs {
    CXConfig* config = [[CXConfig alloc] init];
    
    config.rowid = [rs intForColumn:RowID];
    config.key = [rs stringForColumn:ENConfig_Key];
    config.value = [rs stringForColumn:ENConfig_Value];
    
    return config;
}

#pragma mark - Local Data Service
+(CXConfig*) getConfigWithKey:(NSString*)key {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Select * From %@ Where %@=?", ENConfig, ENConfig_Key];
    __block CXConfig* obj = nil;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        FMResultSet* rs = [db executeQuery:sql, key];
        if ([rs next]) {
            obj = [CXConfig getObjectFromResultSet:rs];
        }
        [rs close];
    }];
    
    return obj;
}

+(int32_t) addConfig:(CXConfig*)c {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Insert Into %@ Values (NULL, ?, ?)", ENConfig];
    __block int32_t result = -1;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:sql, c.key, c.value]) {
            result = (int32_t) [db lastInsertRowId];
        }
    }];
    
    return result;
}

+(BOOL) updateConfig:(CXConfig*)c {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Update %@ Set %@=? Where %@=?", ENConfig, ENConfig_Value, ENConfig_Key];
    __block BOOL result = NO;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql, c.value, c.key];
    }];
    
    return result;
}

@end
