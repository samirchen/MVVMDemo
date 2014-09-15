//
//  CXGroup+LocalDataService.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXGroup+LocalDataService.h"
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import "CXDBConst.h"
#import "CXDBManager.h"

@implementation CXGroup (LocalDataService)

#pragma mark - Utility
+(id) getObjectFromResultSet:(FMResultSet*)rs {
    CXGroup* group = [[CXGroup alloc] init];
    
    group.rowid = [rs intForColumn:RowID];
    group.groupName = [rs stringForColumn:ENGroup_Name];
    group.groupDescription = [rs stringForColumn:ENGroup_Description];
    
    return group;
}

#pragma mark -  Local Data Service
+(NSArray*) getGroupList {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Select * From %@", ENGroup];
    __block NSMutableArray* objs = [[NSMutableArray alloc] init];
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        FMResultSet* rs = [db executeQuery:sql];
        while ([rs next]) {
            [objs addObject:[CXGroup getObjectFromResultSet:rs]];
        }
        [rs close];
    }];
    
    return [objs copy];
}

+(CXGroup*) getGroupWithId:(int32_t)gid {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Select * From %@ Where %@=?", ENGroup, RowID];
    __block CXGroup* obj = nil;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        FMResultSet* rs = [db executeQuery:sql, [NSNumber numberWithInt:gid]];
        if ([rs next]) {
            obj = [CXGroup getObjectFromResultSet:rs];
        }
        [rs close];
    }];
    
    return obj;
}


+(int32_t) addGroup:(CXGroup*)g {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Insert Into %@ Values (NULL, ?, ?)", ENGroup];
    __block int32_t result = -1;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:sql, g.groupName, g.groupDescription]) {
            result = (int32_t) [db lastInsertRowId];
        }
    }];
    
    return result;
}

+(BOOL) updateGroup:(CXGroup*)g {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Update %@ Set %@=?, %@=? Where %@=?", ENGroup, ENGroup_Name, ENGroup_Description, RowID];
    __block BOOL result = NO;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql, g.groupName, g.groupDescription, [NSNumber numberWithInt:g.rowid]];
    }];
    
    return result;
}

+(BOOL) removeGroup:(CXGroup*)g {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Delete From %@ Where %@=?", ENGroup, RowID];
    __block BOOL result = NO;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql, [NSNumber numberWithInt:g.rowid]];
    }];
    
    return result;
}


@end
