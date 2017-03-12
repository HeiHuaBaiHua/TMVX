//
//  UserViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "SelfViewController.h"
#import "UserViewController+Protect.h"

@implementation UserViewController

+ (instancetype)instanceWithUserId:(NSUInteger)userId {
    if (userId == LoginUserId) {
        return [[SelfViewController alloc] initWithUserId:userId];
    } else {
        return [[UserViewController alloc] initWithUserId:userId];
    }
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configuration];
    
    [self addUI];
    
    [self fetchData];
}

#pragma mark - Utils

- (void)configuration {
    
    self.title = [NSString stringWithFormat:@"用户%ld", self.userId];
    self.view.backgroundColor = [UIColor whiteColor];
    self.blogVC = [BlogTableViewController instanceWithUserId:self.userId];
    [self.blogVC setVCGenerator:^UIViewController *(id params) {
        return [BlogDetailViewController instanceWithBlog:params];
    }];
    
    self.userInfoVC = [UserInfoViewController instanceWithUserId:self.userId];
    [self.userInfoVC setVCGenerator:^UIViewController *(id params) {
        return [UserDetailViewController instanceWithUser:params];
    }];
    [self addChildViewController:self.userInfoVC];
}

- (void)addUI {
    
    CGFloat userInfoViewHeight = [UserInfoViewController viewHeight];
    self.userInfoVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, userInfoViewHeight);
    [self.view addSubview:self.userInfoVC.view];
    
    self.blogVC.tableView.frame = CGRectMake(0, self.userInfoVC.view.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.userInfoVC.view.bottom - NAVBAR_HEIGHT);
    [self.view addSubview:self.blogVC.tableView];
}

- (void)fetchData {
    
    [self.userInfoVC fetchData];
    
    [self showHUD];
    [self.blogVC fetchDataWithCompletionHandler:^(NSError *error, id result) {
        [self hideHUD];
    }];
}

@end
