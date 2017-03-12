//
//  BlogCellPresenter.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogCellPresenter.h"

@interface BlogCellPresenter ()

@property (strong, nonatomic) Blog *blog;

@end

@implementation BlogCellPresenter

+ (instancetype)presenterWithBlog:(Blog *)blog {//懒
    BlogCellPresenter *presenter = [BlogCellPresenter new];
    presenter.blog = blog;
    return presenter;
}

#pragma mark - Command

- (void)likeBlogWithCompletionHandler:(NetworkCompletionHandler)completionHandler {
    
    if (self.blog.isLiked) {
        !completionHandler ?: completionHandler([NSError errorWithDomain:@"你已经赞过了哦~" code:123 userInfo:nil], nil);
    } else {
        
        BOOL response = [self.view respondsToSelector:@selector(blogPresenterDidUpdateLikeState:)];
        
        self.blog.isLiked = YES;
        self.blog.likeCount += 1;
        !response ?: [self.view blogPresenterDidUpdateLikeState:self];
        [[UserAPIManager new] likeBlogWithBlogId:self.blog.blogId completionHandler:^(NSError *error, id result) {
            
            if (error) {
                
                self.blog.isLiked = NO;
                self.blog.likeCount -= 1;
                !response ?: [self.view blogPresenterDidUpdateLikeState:self];
            }
            
            !completionHandler ?: completionHandler(error, result);
        }];
    }
}

- (void)shareBlogWithCompletionHandler:(NetworkCompletionHandler)completionHandler {
    //懒
}

#pragma mark - Format

- (BOOL)isLiked {
    return self.blog.isLiked;
}

- (NSString *)blogTitleText {
    return self.blog.blogTitle.length > 0 ? self.self.blog.blogTitle : @"未命名";
}

- (NSString *)blogSummaryText {
    return self.blog.blogSummary.length > 0 ? [NSString stringWithFormat:@"摘要: %@", self.blog.blogSummary] : @"这个人很懒, 什么也没有写...";
}

- (NSString *)blogLikeCountText {
    return [NSString stringWithFormat:@"赞 %ld", self.blog.likeCount];
}

- (NSString *)blogShareCountText {
    return [NSString stringWithFormat:@"分享 %ld", self.blog.shareCount];
}

@end
