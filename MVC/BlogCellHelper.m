//
//  BlogCellHelper.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogCellHelper.h"

@interface BlogCellHelper ()

@property (strong, nonatomic) Blog *blog;

@end

@implementation BlogCellHelper

+ (instancetype)helperWithBlog:(Blog *)blog {//懒
    BlogCellHelper *helper = [BlogCellHelper new];
    helper.blog = blog;
    return helper;
}

- (BOOL)isLiked {
    return self.blog.isLiked;
}

- (NSString *)blogTitleText {
    return self.blog.blogTitle.length > 0 ? self.blog.blogTitle : @"未命名";
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
