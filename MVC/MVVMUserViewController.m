//
//  MVVMUserViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogView.h"
#import "UserInfoController.h"
#import "DetailViewController.h"
#import "MVVMUserViewController.h"
#import "UserInfoViewController.h"

#import "UIView+Alert.h"
#import "UIView+Extension.h"
#import "UIResponder+Router.h"
@interface MVVMUserViewController ()

@property (assign, nonatomic) NSUInteger userId;

@property (strong, nonatomic) BlogView *blogVC;
@property (strong, nonatomic) UserInfoController *userInoController;
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
//    self.userInfoVC = [UserInfoViewController instanceWithUserId:self.userId];
//    [self.userInfoVC setVCGenerator:^UIViewController *(id params) {
//        return [UserDetailViewController instanceWithUser:params];
//    }];
//    [self addChildViewController:self.userInfoVC];
    
    @weakify(self);
    self.userInoController = [UserInfoController instanceWithView:[UserInfoView new] viewModel:[UserInfoViewModel viewModelWithUserId:self.userId]];
    [self.userInoController setOnClickIconCommand:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id user) {
        @strongify(self);
        
        [self.navigationController pushViewController:[UserDetailViewController instanceWithUser:user] animated:YES];
        return [RACSignal empty];
    }]];
    
    self.blogVC = [BlogView instanceWithViewModel:[BlogViewModel viewModelWithUserId:self.userId]];
    [self.blogVC setDidSelectedRowCommand:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(Blog *blog) {
        @strongify(self);
        
        [self.navigationController pushViewController:[BlogDetailViewController instanceWithBlog:blog] animated:YES];
        return [RACSignal empty];
    }]];
}

- (void)addUI {
    
    CGFloat userInfoViewHeight = [UserInfoViewController viewHeight];
//    self.userInoController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, userInfoViewHeight);
//    [self.view addSubview:self.userInoController.view];
//    
//    self.blogVC.tableView.frame = CGRectMake(0, self.userInfoVC.view.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.userInfoVC.view.bottom - NAVBAR_HEIGHT);
    
    self.userInoController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, userInfoViewHeight);
    [self.view addSubview:self.userInoController.view];
    
    self.blogVC.tableView.frame = CGRectMake(0, self.userInoController.view.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.userInoController.view.bottom - NAVBAR_HEIGHT);
    
    [self.view addSubview:self.blogVC.tableView];
}

- (void)fetchData {
    
//    [self.userInfoVC fetchData];
    [self.userInoController fetchData]; //或者直接 [[self.userInoController.viewModel fetchUserInfoCommand] execute:nil];
    [self showHUD];
    [[self.blogVC.fetchDataCommand execute:nil] subscribeError:^(NSError *error) {
        [self hideHUD];
    } completed:^{
        [self hideHUD];
    }];
}

@end
