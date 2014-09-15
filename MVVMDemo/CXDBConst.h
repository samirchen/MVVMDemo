//
//  CXDBConst.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#ifndef MVVMDemo_CXDBConst_h
#define MVVMDemo_CXDBConst_h

/* DB File */
#pragma mark - DB File
#define DB_File @"demo-db.sqlite"
#define DB_Name @"demo-db"
#define DB_Type @"sqlite"

/* Table & Column */
#pragma mark - Table & Column
// common
#define RowID @"rowid"

// en_group
#define ENGroup @"en_group"
#define ENGroup_Name @"name"
#define ENGroup_Description @"description"

// en_person
#define ENPerson @"en_person"
#define ENPerson_Name @"name"
#define ENPerson_Gender @"gender"
#define ENPerson_GroupID @"group_id"

// en_config
#define ENConfig @"en_config"
#define ENConfig_Key @"key"
#define ENConfig_Value @"value"

//// Config Key of config in en_config.
#define ConfigKeyDBVersion @"db_version"

#endif
