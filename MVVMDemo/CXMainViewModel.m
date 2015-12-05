//
//  CXMainViewModel.m
//  MVVMDemo
//
//  Created by qiufu on 12/5/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import "CXMainViewModel.h"
#import "CXMovieService.h"


@interface CXMainViewModel ()
@property (nonatomic, strong) NSArray *movieList;
@property (nonatomic, strong) NSString *categoryTitle;
@end

@implementation CXMainViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataUpdatedSignal = [[RACSubject subject] setNameWithFormat:@"CXMainViewModelUpdatedSignal"];
        self.errorSignal = [[RACSubject subject] setNameWithFormat:@"CXMainViewModelErrorSignal"];
    }
    
    return self;
}

- (void)refreshViewDataWithParameters:(id)parameters {
    
    /*
    // Use block call back.
    [CXMovieService requestMovieDataWithParameters:parameters start:^{
        
    } success:^(NSArray *movieList, NSString *successMessage) {
        
        self.movieList = movieList;
        [(RACSubject *) self.dataUpdatedSignal sendNext:nil];

    } failure:^(NSError *error, NSString *failureMessage) {
        
        [(RACSubject *) self.dataUpdatedSignal sendError:error];
        
    }];
    */
    
    // Use signal.
    RACSignal *movieDataSignal = [CXMovieService signalWhenRequstMovieDataWithParameters:parameters];
    /*
    typeof(self) __weak weakSelf = self;
    [movieDataSignal subscribeNext:^(id x) {
        weakSelf.movieList = x;
        [(RACSubject *) weakSelf.dataUpdatedSignal sendNext:@"movieList"];
    } error:^(NSError *error) {
        //[(RACSubject *) weakSelf.dataUpdatedSignal sendError:error]; // 'sendError' terminates the subscription, and invalidates the subscriber.
        [(RACSubject *) weakSelf.errorSignal sendNext:error];
    } completed:^{
        
    }];
    */
    
    RACSignal *categoryDataSignal = [CXMovieService signalWhenRequstCategoryDataWithParameters:parameters];
    /*
    [categoryDataSignal subscribeNext:^(id x) {
        weakSelf.categoryTitle = x;
        [(RACSubject *) weakSelf.dataUpdatedSignal sendNext:@"categoryTitle"];
    } error:^(NSError *error) {
        //[(RACSubject *) weakSelf.dataUpdatedSignal sendError:error]; // 'sendError' terminates the subscription, and invalidates the subscriber.
        [(RACSubject *) weakSelf.errorSignal sendNext:error];
    } completed:^{
        
    }];
    */
    
    [self rac_liftSelector:@selector(dataUpdatedWithMovieList:categoryTitle:) withSignalsFromArray:@[movieDataSignal, categoryDataSignal]];

    
}


- (void)dataUpdatedWithMovieList:(id)movieList categoryTitle:(id)title {
    self.movieList = movieList;
    self.categoryTitle = title;
    
    [(RACSubject *) self.dataUpdatedSignal sendNext:@"all"];

}

- (NSString *)navigationTitleText {
    return self.categoryTitle;
}

- (NSInteger)movieCellCount {
    NSInteger count = 0;
    
    if (self.movieList) {
        count = self.movieList.count;
    }
    
    return count;
}

- (CXMovieCellViewModel *)movieCellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    CXMovieCellViewModel *cellViewModel = nil;
    if (indexPath.row < self.movieList.count) {
        cellViewModel = [[CXMovieCellViewModel alloc] init];
        CXMovie *movie = self.movieList[indexPath.row];
        cellViewModel.movie = movie;
    }
    
    return cellViewModel;
}


@end
