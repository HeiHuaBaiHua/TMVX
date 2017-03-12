//
//  BlogTableViewCell.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserAPIManager.h"
@interface BlogTableViewCell : UITableViewCell

- (void)setTitle:(NSString *)title;
- (void)setSummary:(NSString *)summary;
- (void)setLikeState:(BOOL)isLiked;
- (void)setLikeCountText:(NSString *)likeCountText;
- (void)setShareCountText:(NSString *)shareCountText;

- (void)setDidLikeHandler:(void(^)())didLikeHandler;
@end
