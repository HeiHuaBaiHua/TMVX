//
//  BlogViewModel.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogViewModel.h"

@interface BlogViewModel ()

@property (assign, nonatomic) NSUInteger userId;
@property (strong, nonatomic) UserAPIManager *apiManager;
@property (strong, nonatomic) NSMutableArray<BlogCellViewModel *> *blogs;

@property (strong, nonatomic) RACSignal *refreshDataSignal;
@property (strong, nonatomic) RACSignal *loadMoreDataSignal;
@end

@implementation BlogViewModel

+ (instancetype)viewModelWithUserId:(NSUInteger)userId {
    return [[BlogViewModel alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        
        self.blogs = [NSMutableArray array];
        self.userId = userId;
        self.apiManager = [UserAPIManager new];
        
        @weakify(self);
        self.refreshDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            [self.apiManager refreshUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
                
                if (!error) {
                    
                    [self.blogs removeAllObjects];
                    [self formatResult:result];
                }
                error ? [subscriber sendError:error] : [subscriber sendCompleted];
            }];
            return nil;
        }];
        self.loadMoreDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            [self.apiManager loadModeUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
                
                error ?: [self formatResult:result];
                error ? [subscriber sendError:error] : [subscriber sendCompleted];
            }];
            return nil;
        }];
    }
    return self;
}

#pragma mark - Interface

- (NSArray *)allDatas {
    return self.blogs;
}

#pragma mark - Utils

- (void)formatResult:(NSArray *)blogs {
    
    for (Blog *blog in blogs) {
        [self.blogs addObject:[BlogCellViewModel viewModelWithBlog:blog]];
    }
}


@end
