//
//  BlogCellPresenter.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Blog.h"
#import "UserAPIManager.h"

@class BlogCellPresenter;
@protocol BlogCellPresenterCallBack <NSObject>

@optional
- (void)blogPresenterDidUpdateLikeState:(BlogCellPresenter *)presenter;
- (void)blogPresenterDidUpdateShareState:(BlogCellPresenter *)presenter;

@end

@interface BlogCellPresenter : NSObject

@property (weak, nonatomic) id<BlogCellPresenterCallBack> view;

+ (instancetype)presenterWithBlog:(Blog *)blog;

- (Blog *)blog;

- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogSummaryText;
- (NSString *)blogLikeCountText;
- (NSString *)blogShareCountText;

- (void)likeBlogWithCompletionHandler:(NetworkCompletionHandler)completionHandler;
- (void)shareBlogWithCompletionHandler:(NetworkCompletionHandler)completionHandler;
@end
