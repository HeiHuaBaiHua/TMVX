//
//  MVPUserViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "MVPUserViewController.h"

#import "BlogViewController.h"
#import "DraftViewController.h"
#import "DetailViewController.h"
#import "UserInfoViewController.h"

#import "UIView+Alert.h"
#import "UIView+Extension.h"

@interface MVPUserViewController ()<BlogViewControllerCallBack>

@property (assign, nonatomic) NSUInteger userId;

@property (strong, nonatomic) UIButton *blogButton;
@property (strong, nonatomic) UIButton *draftButton;
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) BlogViewController *blogVC;
@property (strong, nonatomic) DraftViewController *draftVC;
@property (strong, nonatomic) UserInfoViewController *userInfoVC;

@end

@implementation MVPUserViewController

+ (instancetype)instanceWithUserId:(NSUInteger)userId {
    return [[MVPUserViewController alloc] initWiWithUserId:userId];
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

#pragma mark - BlogViewControllerCallBack

- (void)blogViewControllerdidSelectBlog:(Blog *)blog {
    [self.navigationController pushViewController:[BlogDetailViewController instanceWithBlog:blog] animated:YES];
}

#pragma mark - Action

- (void)switchTableView:(UIButton *)button {
    
    if (button == self.blogButton) {
        
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        self.draftButton.selected = NO;
    } else {
        
        self.blogButton.selected = NO;
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
    button.selected = YES;
}

#pragma mark - Utils

- (void)configuration {
    
    self.title = [NSString stringWithFormat:@"用户%ld", self.userId];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //因为MVP中的PV关系理论上是多对多的, 所以P层通常都是由MVP的上层直接分配而不是在C层默认创建, 这样在逻辑变动布局不变的情况下, 上层只需要分配一个新的P层就行了, 同理, 如果逻辑不变布局变了, 上层就替换V层即可.
    //更标准的写法是针对每个M都有对应V,C,P, V负责布局 ,C负责和上层交互(某个业务场景的具体需求, 比如HUD), P负责业务逻辑(各种格式化, 各种命令), 但这里因为我偷懒没有建立DraftView而是将TableViewDataSource布局直接写在C层了, 所以此时的DraftViewController即是C也是V.
    
    __weak typeof(self) weakSelf = self;
    self.draftVC = [DraftViewController instanceWithPresenter:[DraftViewPresenter presenterWithUserId:self.userId]];//DraftViewController走的是Block绑定方式
    [self.draftVC setDidSelectedRowHandler:^(Draft *draft) {
        [weakSelf.navigationController pushViewController:[DraftDetailViewController instanceWithDraft:draft] animated:YES];
    }];
    
    self.blogVC = [BlogViewController instanceWithPresenter:[BlogViewPresenter presenterWithUserId:self.userId]];
    self.blogVC.delegate = self;//BlogViewController走的是Protocol绑定方式
    
    self.userInfoVC = [UserInfoViewController instanceWithUserId:self.userId];
    [self.userInfoVC setVCGenerator:^UIViewController *(id params) {
        return [UserDetailViewController instanceWithUser:params];
    }];
    [self addChildViewController:self.userInfoVC];//userInfo还是用的MVC 毕竟上面把block和protocol都交代过了
}

- (void)addUI {
    
    CGFloat userInfoViewHeight = [UserInfoViewController viewHeight];
    self.userInfoVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, userInfoViewHeight);
    [self.view addSubview:self.userInfoVC.view];
    
    UIButton *(^makeButton)(NSString *, CGRect) = ^(NSString *title, CGRect frame) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(switchTableView:) forControlEvents:UIControlEventTouchUpInside];
        return button;
    };
    
    CGFloat switchButtonTop = self.userInfoVC.view.bottom;
    CGFloat switchButtonHeight = 40;
    [self.view addSubview:self.blogButton = makeButton(@"博客", CGRectMake(0, switchButtonTop, SCREEN_WIDTH * 0.5, switchButtonHeight))];
    [self.view addSubview:self.draftButton = makeButton(@"草稿", CGRectMake(SCREEN_WIDTH * 0.5, switchButtonTop, SCREEN_WIDTH * 0.5, switchButtonHeight))];
    self.blogButton.selected = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.blogButton.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.blogButton.bottom - NAVBAR_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView = scrollView];
    
    self.blogVC.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, scrollView.height);
    [self.scrollView addSubview:self.blogVC.tableView];
    
    self.draftVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollView.height);
    [self.scrollView addSubview:self.draftVC.tableView];
}

- (void)fetchData {
    
    [self.userInfoVC fetchData];
    
    [self showHUD];//上层交互逻辑
    [self.blogVC.presenter fetchDataWithCompletionHandler:^(NSError *error, id result) {
        [self hideHUD];//上层交互逻辑
    }];
    
    [self.draftVC fetchDataWithCompletionHandler:nil];
}

@end
