//
//  BlogCellViewModel.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Blog.h"
#import "ReactiveCocoa.h"
#import "UserAPIManager.h"

extern NSString *LikeBlogEvent;
extern NSString *kCellViewModel;
@interface BlogCellViewModel : NSObject

+ (instancetype)viewModelWithBlog:(Blog *)blog;

- (Blog *)blog;

- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogSummaryText;
- (NSString *)blogLikeCount;
- (NSString *)blogShareCount;

- (RACCommand *)likeBlogCommand;
- (RACCommand *)shareBlogCommand;

@end
