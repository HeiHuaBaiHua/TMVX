//
//  BlogCellHelper.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Blog.h"
@interface BlogCellHelper : NSObject

+ (instancetype)helperWithBlog:(Blog *)blog;

- (Blog *)blog;

- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogSummaryText;
- (NSString *)blogLikeCountText;
- (NSString *)blogShareCountText;

@end
