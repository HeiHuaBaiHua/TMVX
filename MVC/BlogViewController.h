//
//  BlogViewController.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Blog.h"
#import "BlogViewPresenter.h"
@protocol BlogViewControllerCallBack <NSObject>

- (void)blogViewControllerdidSelectBlog:(Blog *)blog;

@end

@interface BlogViewController : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id<BlogViewControllerCallBack> delegate;

+ (instancetype)instanceWithPresenter:(BlogViewPresenter *)presenter;

- (UITableView *)tableView;
- (BlogViewPresenter *)presenter;
@end
