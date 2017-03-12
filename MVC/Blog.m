//
//  Blog.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "Blog.h"

@implementation Blog

- (instancetype)initWithBlogId:(NSUInteger)blogId {
    
    self.blogId = blogId;
    self.isLiked = blogId % 2;
    self.likeCount = blogId + 10;
    self.blogTitle = [NSString stringWithFormat:@"blogTitle%ld", blogId];
    self.shareCount = blogId + 8;
    self.blogSummary = [NSString stringWithFormat:@"blogSummary%ld", blogId];
    
    return self;
}

@end
