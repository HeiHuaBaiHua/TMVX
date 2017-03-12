//
//  DraftViewPresenter.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "DraftViewPresenter.h"

@interface DraftViewPresenter ()

@property (assign, nonatomic) NSUInteger userId;
@property (strong, nonatomic) UserAPIManager *apiManager;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<DraftCellPresenter *> *drafts;

@end

@implementation DraftViewPresenter

+ (instancetype)presenterWithUserId:(NSUInteger)userId {
    return [[DraftViewPresenter alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        
        self.userId = userId;
        self.drafts = [NSMutableArray array];
        self.apiManager = [UserAPIManager new];
    }
    return self;
}

#pragma mark - Interface

- (NSArray *)allDatas {
    return self.drafts;
}

- (void)refreshDataWithCompletionHandler:(NetworkCompletionHandler)completionHander {
    [self.apiManager refreshUserDraftsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        
        if (!error) {
            
            [self.drafts removeAllObjects];
            [self formatResult:result];//格式化返回结果
        } else {
//            如果API层面没有格式化好错误 那么在P层格式化错误
        }
        
        !completionHander ?: completionHander(error, result);
    }];
}

- (void)loadMoreDataWithCompletionHandler:(NetworkCompletionHandler)completionHander {
    
    [self.apiManager loadModeUserDraftsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        
        if (!error) {
            [self formatResult:result];//格式化返回结果
        } else {
//            如果API层面没有格式化好错误 那么在P层格式化错误
        }
        
        !completionHander ?: completionHander(error, result);
    }];
}

- (void)deleteDraftAtIndex:(NSUInteger)index completionHandler:(NetworkCompletionHandler)completionHander {
    if (index >= self.drafts.count) {
        !completionHander ?: completionHander([NSError new], nil);
    } else {
        
        [self.drafts[index] deleteDraftWithCompletionHandler:^(NSError *error, id result) {
            
            error ?: [self.drafts removeObjectAtIndex:index];
            
            !completionHander ?: completionHander(error, result);
        }];
    }
}

#pragma mark - Utils

- (void)formatResult:(NSArray *)drafts {
    
    for (Draft *draft in drafts) {
        [self.drafts addObject:[DraftCellPresenter presenterWithDraft:draft]];
    }
}

@end
