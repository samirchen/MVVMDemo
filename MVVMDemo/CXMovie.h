//
//  CXMovie.h
//  MVVMDemo
//
//  Created by qiufu on 12/4/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMovie : NSObject

@property (nonatomic, strong) NSString *posterImageURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *releaseTime;

@end
