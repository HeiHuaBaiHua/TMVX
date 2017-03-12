//
//  BlogViewPresenter.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BlogCellPresenter.h"

@class BlogViewPresenter;
@protocol BlogViewPresenterCallBack <NSObject>

- (void)blogViewPresenter:(BlogViewPresenter *)presenter didRefreshDataWithResult:(id)result error:(NSError *)error;
- (void)blogViewPresenter:(BlogViewPresenter *)presenter didLoadMoreDataWithResult:(id)result error:(NSError *)error;

@end

@interface BlogViewPresenter : NSObject

@property (weak, nonatomic) id<BlogViewPresenterCallBack> view;

+ (instancetype)presenterWithUserId:(NSUInteger)userId;

- (NSArray<BlogCellPresenter *> *)allDatas;

- (void)refreshData;
- (void)loadMoreData;
- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHander;
@end
