//
//  PersonListViewModel.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXPersonListViewModel.h"
#import "CXPerson+LocalDataService.h"
#import "CXGroup.h"

@interface CXPersonListViewModel ()
@property (nonatomic, strong) NSArray* persons;
@end

@implementation CXPersonListViewModel

#pragma mark - Property
-(NSInteger) numberOfPersons {
    return [self.persons count];
}

#pragma mark - Init
-(instancetype) initWithGroup:(CXGroup *)g {
    self = [super init];
    if (self) {
        self.group = g;
        if (g) {
            self.persons = [CXPerson getPersonListWithGroupId:g.rowid];
        }
    }
    
    return self;
}

#pragma mark - Public Method
-(CXPerson*) personAtIndex:(NSInteger)index {
    return [self.persons objectAtIndex:index];
}

-(NSString*) titleForPersonAtIndex:(NSInteger)index {
    return [[self.persons objectAtIndex:index] personName];
}

-(NSString*) subtitleForPersonAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"Gender: %d", [[self.persons objectAtIndex:index] gender]];
}



@end
