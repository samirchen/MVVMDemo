//
//  CXDBManager.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXDBManager.h"
#import "CXDBConst.h"
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import "CXConst.h"
#import "CXConfig+LocalDataService.h"
#import "CXGroup+LocalDataService.h"
#import "CXPerson+LocalDataService.h"

static CXDBManager* SharedInstance = nil;

typedef NS_ENUM(int32_t, DBVersion) {
    DBVersion0 = 0,
    DBVersion1,
    DBVersion2
};

@interface CXDBManager ()
@property (nonatomic, strong, readwrite) NSString* dbFilePath;
@end

@implementation CXDBManager

#pragma mark - Properties
-(NSString*) dbFilePath {
    if (!_dbFilePath) {
        _dbFilePath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:DB_File];
    }
    
    return _dbFilePath;
}

#pragma mark - Shared Instance
+(CXDBManager*) sharedInstance {
    @synchronized(self) {
        if (SharedInstance == nil) {
            SharedInstance = [[CXDBManager alloc] init];
        }
    }
    
    return SharedInstance;
}

#pragma mark - CXDBManager
-(void) initDB {
    DBVersion dbVersion = DBVersion0;
    if (![self isDBFileExist]) { // DB is not exist
        BOOL copyDBOK = [self copyDBFileFromMainBundle]; // Copy from main bundle.
        if (!copyDBOK) {
            [self createDB]; // Create.
        }
    }
    else { // DB is exist, update DB depends on its version.
        // Get DB version.
        dbVersion = [self getDBVersion];
    }
    
    // DO NOT add "break" in each case. Update in order version by version.
    switch (dbVersion) { // Always update to next version.
        case DBVersion0:
            [self updateToDBV1];
            
        case DBVersion1:
            [self updateToDBV2];
            
        default:
            break;
    }
}

-(BOOL) isDBFileExist {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.dbFilePath];
}

-(BOOL) createDB {
    if ([FMDatabase databaseWithPath:self.dbFilePath] != nil) {
        return YES;
    }
    
    return NO;
}

-(BOOL) copyDBFileFromMainBundle {
    
    BOOL result = NO;
    
    // Could not find db file, need to copy.
    NSString* backupDbPath = [[NSBundle mainBundle] pathForResource:DB_Name ofType:DB_Type];
    if (backupDbPath == nil) {
        // Could not find backup db to copy.
        debugLog(@"No backup DB...");
        result = NO;
    }
    else {
        BOOL copiedBackupDb = [[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:self.dbFilePath error:nil];
        if (!copiedBackupDb) {
            // Copy backup db file failed.
            debugLog(@"Copied error...");
            result = NO;
        }
        else {
            result = YES;
        }
    }
    
    return result;
    
}

-(DBVersion) getDBVersion {
    DBVersion v = DBVersion0;
    
    CXConfig* config = [CXConfig getConfigWithKey:kConfigKeyDBVersion];
    if (config) {
        v = (int32_t)config.value.intValue;
    }
    
    return v;
}

#pragma mark - DB Update
-(void) updateToDBV1 {
    
    FMDatabaseQueue *dbQ = [FMDatabaseQueue databaseQueueWithPath:self.dbFilePath];
    [dbQ inTransaction:^(FMDatabase *db, BOOL *rollback) {
        // Create en_group.
        [db executeUpdate:[NSString stringWithFormat:@"Create Table If Not Exists %@ (%@ integer primary key autoincrement not null, %@ text, %@ text);", ENGroup, RowID, ENGroup_Name, ENGroup_Description]];
        // Create en_person.
        [db executeUpdate:[NSString stringWithFormat:@"Create Table If Not Exists %@ (%@ integer primary key autoincrement not null, %@ text, %@ integer, %@ integer);", ENPerson, RowID, ENPerson_Name, ENPerson_Gender, ENPerson_GroupID]];
        // Create en_config.
        [db executeUpdate:[NSString stringWithFormat:@"Create Table If Not Exists %@ (%@ integer primary key autoincrement not null, %@ text, %@ text);", ENConfig, RowID, ENConfig_Key, ENConfig_Value]];
    }];
    
    // Set DB version.
    CXConfig* dbVersionConfig = [[CXConfig alloc] initWithConfigKey:kConfigKeyDBVersion value:[NSString stringWithFormat:@"%d", DBVersion1]];
    [CXConfig addConfig:dbVersionConfig];
    
    // Test Data.
    for (int i = 0; i < 10; i++) {
        CXGroup* g = [[CXGroup alloc] initWithName:[NSString stringWithFormat:@"Group-%d", i] description:[NSString stringWithFormat:@"Hi, I am Group-%d", i]];
        g.rowid = [CXGroup addGroup:g];
        for (int j = 0; j < 10; j++) {
            CXPerson* p = [[CXPerson alloc] initWithName:[NSString stringWithFormat:@"Person-%d-%d", i, j] gender:j%2 groupId:g.rowid];
            p.rowid = [CXPerson addPerson:p];
        }
    }
    
    
    
}


-(void) updateToDBV2 {
    
    // Test: Run in background to update data.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            if (arc4random() % 2) {
                int i = arc4random() % 100;
                CXGroup* g = [[CXGroup alloc] initWithName:[NSString stringWithFormat:@"Group-%d", i] description:[NSString stringWithFormat:@"Hi, I am Group-%d", i]];
                BOOL r = [CXGroup addGroup:g];
                if (r) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationGroupDataUpdated object:nil];
                }
            }
            else {
                NSArray* gs = [CXGroup getGroupList];
                if (gs.count > 0) {
                    int x = arc4random() % gs.count;
                    BOOL r = [CXGroup removeGroup:gs[x]];
                    if (r) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationGroupDataUpdated object:nil];
                    }
                }
            }
                        
            [NSThread sleepForTimeInterval:5];
        }
    });
    
}

@end
