//
//  CXGroupEditViewModel.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-20.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXGroup;

@interface CXGroupEditViewModel : NSObject

@property (nonatomic, readonly) CXGroup* group;
@property (nonatomic, readonly) NSString* nameString;
@property (nonatomic, readonly) NSString* descriptionString;


-(instancetype) initWithGroup:(CXGroup *)g;

@end
