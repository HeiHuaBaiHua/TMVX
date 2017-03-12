//
//  Blog.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Blog : NSObject

- (instancetype)initWithBlogId:(NSUInteger)blogId;

@property (copy, nonatomic) NSString *blogTitle;
@property (copy, nonatomic) NSString *blogSummary;
@property (assign, nonatomic) BOOL isLiked;
@property (assign, nonatomic) NSUInteger blogId;
@property (assign, nonatomic) NSUInteger likeCount;
@property (assign, nonatomic) NSUInteger shareCount;

@end
