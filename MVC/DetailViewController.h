//
//  DetailViewController.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class Blog;
@class Draft;

@interface UserDetailViewController : UIViewController
+ (instancetype)instanceWithUser:(User *)user;
@end

@interface BlogDetailViewController : UIViewController
+ (instancetype)instanceWithBlog:(Blog *)blog;
@end

@interface DraftDetailViewController : UIViewController
+ (instancetype)instanceWithDraft:(Draft *)draft;

@end
