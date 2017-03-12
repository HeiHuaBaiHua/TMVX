//
//  UserViewController+Protect.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "UserViewController.h"

#import "DetailViewController.h"
#import "UserInfoViewController.h"
#import "BlogTableViewController.h"
#import "DraftTableViewController.h"

#import "UIView+Alert.h"
#import "UIView+Extension.h"

@interface UserViewController ()

@property (assign, nonatomic) NSUInteger userId;

@property (strong, nonatomic) UserInfoViewController *userInfoVC;
@property (strong, nonatomic) BlogTableViewController *blogVC;

- (void)addUI;
- (void)fetchData;
- (void)configuration;
@end
