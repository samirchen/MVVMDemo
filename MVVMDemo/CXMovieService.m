//
//  CXMovieService.m
//  MVVMDemo
//
//  Created by qiufu on 12/5/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import "CXMovieService.h"
#import "CXMovie.h"
#import "CXCommonUtil.h"


@implementation CXMovieService

+ (void)requestMovieDataWithParameters:(id)parameters start:(void (^)(void))start success:(void (^)(NSArray *movieList, NSString *successMessage))success failure:(void (^)(NSError *error, NSString *failureMessage))failure {
    
    start();
    
    // 模拟从网络获取到数据。
    if (arc4random() % 100 != 0) {
        
        NSMutableArray *movies = [[NSMutableArray alloc] init];
        for (int32_t i = 0; i < (arc4random() % 20 + 1); i++) {
            CXMovie *m = [[CXMovie alloc] init];
            m.posterImageURL = @"http://img.sc115.com/uploads/sc/jpgs/07/pic5093_sc115.com.jpg";
            m.name = [CXCommonUtil randomStringWithLength:10];
            m.releaseTime = [NSDate dateWithTimeIntervalSince1970:(arc4random() % 10000000)];

            [movies addObject:m];
        }
        
        success([movies copy], @"成功获得电影信息。");
    }
    else {
        NSError *error = [[NSError alloc] initWithDomain:@"www.movie.com" code:-99 userInfo:nil];
        failure(error, @"获取电影信息失败。");
    }
    
    
}

+ (RACSignal *)signalWhenRequstMovieDataWithParameters:(id)parameters {
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [CXMovieService requestMovieDataWithParameters:parameters start:^{
            
        } success:^(NSArray *movieList, NSString *successMessage) {
            [subscriber sendNext:movieList];
            [subscriber sendCompleted]; // This terminates the subscription, and invalidates the subscriber
        } failure:^(NSError *error, NSString *failureMessage) {
            [subscriber sendError:error]; // This terminates the subscription, and invalidates the subscriber
        }];
        
        return nil;//[RACDisposable disposableWithBlock:^{}];
        
    }];
    
    return dataSignal;
}


+ (void)requestCategoryDataWithParameters:(id)parameters start:(void (^)(void))start success:(void (^)(NSString *categoryTitle, NSString *successMessage))success failure:(void (^)(NSError *error, NSString *failureMessage))failure {

    start();
    
    // 模拟从网络获取到数据。
    if (arc4random() % 100 != 0) {
        
        NSString *title = [CXCommonUtil randomStringWithLength:10];
        
        success(title, @"成功获得类别信息。");
    }
    else {
        NSError *error = [[NSError alloc] initWithDomain:@"www.movie.com" code:-99 userInfo:nil];
        failure(error, @"获取类别信息失败。");
    }

}


+ (RACSignal *)signalWhenRequstCategoryDataWithParameters:(id)parameters {
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [CXMovieService requestCategoryDataWithParameters:parameters start:^{
            
        } success:^(NSString *categoryTitle, NSString *successMessage) {
            [subscriber sendNext:categoryTitle];
            [subscriber sendCompleted]; // This terminates the subscription, and invalidates the subscriber
        } failure:^(NSError *error, NSString *failureMessage) {
            [subscriber sendError:error]; // This terminates the subscription, and invalidates the subscriber
        }];
        
        return nil;//[RACDisposable disposableWithBlock:^{}];
        
    }];
    
    return dataSignal;

}



@end
