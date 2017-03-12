//
//  BlogCellViewModel.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogCellViewModel.h"

NSString *LikeBlogEvent = @"LikeBlogEvent";
NSString *kCellViewModel = @"kCellViewModel";

@interface BlogCellViewModel ()

@property (strong, nonatomic) Blog *blog;
@property (strong, nonatomic) RACCommand *likeBlogCommand;

@end

@implementation BlogCellViewModel

+ (instancetype)viewModelWithBlog:(Blog *)blog {
    return [[BlogCellViewModel alloc] initWithBlog:blog];
}

- (instancetype)initWithBlog:(Blog *)blog {
    if (self = [super init]) {
        self.blog = blog;
        
        @weakify(self);
        self.likeBlogCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
         
            RACSubject *subject = [RACSubject subject];
            if (self.isLiked) {

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    self.isLiked = NO;
                    self.blogLikeCount = self.blog.likeCount - 1;
                    [subject sendCompleted];
                });
            } else {
                
                self.isLiked = YES;
                self.blogLikeCount = self.blog.likeCount + 1;
                [[UserAPIManager new] likeBlogWithBlogId:self.blog.blogId completionHandler:^(NSError *error, id result) {
                    
                    if (error) {
                        
                        self.isLiked = NO;
                        self.blogLikeCount = self.blog.likeCount - 1;
                    }
                    error ? [subject sendError:error] : [subject sendCompleted];
                }];
            }
            return subject;
        }];
    }
    return self;
}

#pragma mark - Format

- (BOOL)isLiked {
    return self.blog.isLiked;
}

- (void)setIsLiked:(BOOL)isLiked {
    self.blog.isLiked = isLiked;
}

- (NSString *)blogTitleText {
    return self.blog.blogTitle.length > 0 ? self.self.blog.blogTitle : @"未命名";
}

- (NSString *)blogSummaryText {
    return self.blog.blogSummary.length > 0 ? [NSString stringWithFormat:@"摘要: %@", self.blog.blogSummary] : @"这个人很懒, 什么也没有写...";
}

- (NSString *)blogLikeCount {
    return [NSString stringWithFormat:@"赞 %ld", self.blog.likeCount];
}

- (void)setBlogLikeCount:(NSUInteger)likeCount {
    self.blog.likeCount = likeCount;
}

- (NSString *)blogShareCount {
    return [NSString stringWithFormat:@"分享 %ld", self.blog.shareCount];
}

@end
