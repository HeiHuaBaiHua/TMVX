//
//  BlogViewPresenter.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogViewPresenter.h"

@interface BlogViewPresenter ()

@property (assign, nonatomic) NSUInteger userId;
@property (strong, nonatomic) UserAPIManager *apiManager;
@property (strong, nonatomic) NSMutableArray<BlogCellPresenter *> *blogs;

@end

@implementation BlogViewPresenter

+ (instancetype)presenterWithUserId:(NSUInteger)userId {
    return [[BlogViewPresenter alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        
        self.blogs = [NSMutableArray array];
        self.userId = userId;
        self.apiManager = [UserAPIManager new];
    }
    return self;
}

#pragma mark - Interface

- (NSArray *)allDatas {
    return self.blogs;
}

- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHander {
    
    [self.apiManager refreshUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        
        if (!error) {
            
            [self.blogs removeAllObjects];
            [self formatResult:result];
        }
        
        if ([self.view respondsToSelector:@selector(blogViewPresenter:didRefreshDataWithResult:error:)]) {
            [self.view blogViewPresenter:self didRefreshDataWithResult:result error:error];
        }
        
        !completionHander ?: completionHander(error, result);
    }];
}

- (void)refreshData {
    [self fetchDataWithCompletionHandler:nil];
}

- (void)loadMoreData {
    
    [self.apiManager loadModeUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        
        error ?: [self formatResult:result];
        
        if ([self.view respondsToSelector:@selector(blogViewPresenter:didLoadMoreDataWithResult:error:)]) {
            [self.view blogViewPresenter:self didLoadMoreDataWithResult:result error:error];
        }
    }];
}

#pragma mark - Utils

- (void)formatResult:(NSArray *)blogs {
    
    for (Blog *blog in blogs) {
        [self.blogs addObject:[BlogCellPresenter presenterWithBlog:blog]];
    }
}

@end
