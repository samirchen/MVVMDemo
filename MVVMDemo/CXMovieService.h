//
//  CXMovieService.h
//  MVVMDemo
//
//  Created by qiufu on 12/5/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "CXMovie.h"

@interface CXMovieService : NSObject

+ (void)requestMovieDataWithParameters:(id)parameters start:(void (^)(void))start success:(void (^)(NSArray *movieList, NSString *successMessage))success failure:(void (^)(NSError *error, NSString *failureMessage))failure;
+ (RACSignal *)signalWhenRequstMovieDataWithParameters:(id)parameters;

+ (void)requestCategoryDataWithParameters:(id)parameters start:(void (^)(void))start success:(void (^)(NSString *categoryTitle, NSString *successMessage))success failure:(void (^)(NSError *error, NSString *failureMessage))failure;
+ (RACSignal *)signalWhenRequstCategoryDataWithParameters:(id)parameters;


@end
