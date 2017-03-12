//
//  MVVMUserViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogView.h"
#import "DetailViewController.h"
#import "MVVMUserViewController.h"
#import "UserInfoViewController.h"

#import "UIView+Alert.h"
#import "UIView+Extension.h"
#import "UIResponder+Router.h"
@interface MVVMUserViewController ()

@property (assign, nonatomic) NSUInteger userId;

@property (strong, nonatomic) BlogView *blogVC;
@property (strong, nonatomic) UserInfoViewController *userInfoVC;

@end

@implementation MVVMUserViewController

+ (instancetype)instanceWithUserId:(NSUInteger)userId {
    return [[MVVMUserViewController alloc] initWiWithUserId:userId];
}

- (instancetype)initWiWithUserId:(NSUInteger)userId {
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

#pragma mark - Router

- (void)routeEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:LikeBlogEvent]) {
        
        BlogCellViewModel *viewModel = userInfo[kCellViewModel];
        if (!viewModel.isLiked) {
            
            [[viewModel.likeBlogCommand execute:nil] subscribeError:^(NSError *error) {
                [self showToastWithText:error.domain];
            }];
        } else {
            
            [self showAlertWithTitle:@"提示" message:@"确定取消点赞吗?" confirmHandler:^(UIAlertAction *confirmAction) {
                [[viewModel.likeBlogCommand execute:nil] subscribeError:^(NSError *error) {
                    [self showToastWithText:error.domain];
                }];
            }];
        }
    }
}

#pragma mark - Utils

- (void)configuration {
    
    self.title = @"MVVM";
    self.view.backgroundColor = [UIColor whiteColor];
    self.userInfoVC = [UserInfoViewController instanceWithUserId:self.userId];
    [self.userInfoVC setVCGenerator:^UIViewController *(id params) {
        return [UserDetailViewController instanceWithUser:params];
    }];
    [self addChildViewController:self.userInfoVC];
    
    self.blogVC = [BlogView instanceWithViewModel:[BlogViewModel viewModelWithUserId:self.userId]];
    __weak typeof(self) weakSelf = self;
    [self.blogVC setDidSelectedRowCommand:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(Blog *blog) {

        [weakSelf.navigationController pushViewController:[BlogDetailViewController instanceWithBlog:blog] animated:YES];
        return [RACSignal empty];
    }]];
}

- (void)addUI {
    
    CGFloat userInfoViewHeight = [UserInfoViewController viewHeight];
    self.userInfoVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, userInfoViewHeight);
    [self.view addSubview:self.userInfoVC.view];
    
    self.blogVC.tableView.frame = CGRectMake(0, self.userInfoVC.view.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.userInfoVC.view.bottom - NAVBAR_HEIGHT);
    [self.view addSubview:self.blogVC.tableView];//只写了blog模块 其他的模块写法差不多 多写也没意义
}

- (void)fetchData {
    
    [self.userInfoVC fetchData];
    [self showHUD];
    [[self.blogVC.fetchDataCommand execute:nil] subscribeError:^(NSError *error) {
        [self hideHUD];
    } completed:^{
        [self hideHUD];
    }];
}

@end
