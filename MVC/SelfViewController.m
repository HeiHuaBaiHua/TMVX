//
//  SelfViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "SelfViewController.h"
#import "UserViewController+Protect.h"

@interface SelfViewController ()

@property (strong, nonatomic) UIButton *blogButton;
@property (strong, nonatomic) UIButton *draftButton;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) DraftTableViewController *draftVC;

@end

@implementation SelfViewController

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

#pragma mark - Override

- (void)configuration {
    [super configuration];
    
    self.title = @"我";
    self.draftVC = [DraftTableViewController instanceWithUserId:self.userId];
    __weak typeof(self) weakSelf = self;
    [self.draftVC setDidSelectedRowHandler:^(Draft *draft) {
        [weakSelf.navigationController pushViewController:[DraftDetailViewController instanceWithDraft:draft] animated:YES];
    }];
}

- (void)addUI {
    [super addUI];
    
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
    [super fetchData];

    [self.draftVC fetchData];
}

@end
