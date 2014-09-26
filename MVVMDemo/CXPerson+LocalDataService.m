//
//  CXPerson+LocalDataService.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXPerson+LocalDataService.h"
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import "CXDBConst.h"
#import "CXDBManager.h"

@implementation CXPerson (LocalDataService)

#pragma mark - Utility
+(id) getObjectFromResultSet:(FMResultSet*)rs {
    CXPerson* person = [[CXPerson alloc] init];
    
    person.rowid = [rs intForColumn:RowID];
    person.personName = [rs stringForColumn:ENPerson_Name];
    person.gender = [rs intForColumn:ENPerson_Gender];
    person.groupId = [rs intForColumn:ENPerson_GroupID];
    
    return person;
}

#pragma mark - Local Data Service
+(NSArray*) getPersonListWithGroupId:(int32_t)groupId {
    
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Select * From %@ Where %@=?", ENPerson, ENPerson_GroupID];
    __block NSMutableArray* objs = [[NSMutableArray alloc] init];
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        [db open];
        FMResultSet* rs = [db executeQuery:sql, [NSNumber numberWithInt:groupId]];
        while ([rs next]) {
            [objs addObject:[CXPerson getObjectFromResultSet:rs]];
        }
        [rs close];
        [db close];
    }];
    
    return [objs copy];
}

+(int32_t) addPerson:(CXPerson*)p {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Insert Into %@ Values (NULL, ?, ?, ?)", ENPerson];
    __block int32_t result = -1;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        [db open];
        if ([db executeUpdate:sql, p.personName, [NSNumber numberWithInt:p.gender], [NSNumber numberWithInt:p.groupId]]) {
            result = (int32_t) [db lastInsertRowId];
        }
        [db close];
    }];
    
    return result;
}

+(BOOL) updatePerson:(CXPerson*)p {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Update %@ Set %@=?, %@=?, %@=? Where %@=?", ENPerson, ENPerson_Name, ENPerson_Gender, ENPerson_GroupID, RowID];
    __block BOOL result = NO;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        [db open];
        result = [db executeUpdate:sql, p.personName, [NSNumber numberWithInt:p.gender], [NSNumber numberWithInt:p.groupId], [NSNumber numberWithInt:p.rowid]];
        [db close];
    }];
    
    return result;
}

+(BOOL) removePerson:(CXPerson*)p {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Delete From %@ Where %@=?", ENPerson, RowID];
    __block BOOL result = NO;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        [db open];
        result = [db executeUpdate:sql, [NSNumber numberWithInt:p.rowid]];
        [db close];
    }];
    
    return result;
}

+(BOOL) removePersonOfGroup:(int32_t)groupId {
    NSString* dbFilePath = [CXDBManager sharedInstance].dbFilePath;
    NSString* sql = [NSString stringWithFormat:@"Delete From %@ Where %@=?", ENPerson, ENPerson_GroupID];
    __block BOOL result = NO;
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [dbQ inDatabase:^(FMDatabase *db) {
        [db open];
        result = [db executeUpdate:sql, [NSNumber numberWithInt:groupId]];
        [db close];
    }];

    return result;

}


@end
