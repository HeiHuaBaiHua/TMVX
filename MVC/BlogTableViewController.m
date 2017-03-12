//
//  BlogTableViewHelper.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogTableViewController.h"

#import "MJRefresh.h"
#import "BlogTableViewCell.h"

#import "UIView+Alert.h"
#import "BlogCellHelper.h"
#import "UIView+Controller.h"

@interface BlogTableViewController ()

@property (copy, nonatomic) ViewControllerGenerator VCGenerator;
@property (assign, nonatomic) NSUInteger userId;
@property (strong, nonatomic) UserAPIManager *apiManager;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<BlogCellHelper *> *blogs;

@end

#define RowHeight 44
#define ReuseIdentifier @"BlogTableViewCell"
@implementation BlogTableViewController

+ (instancetype)instanceWithUserId:(NSUInteger)userId {
    return [[BlogTableViewController alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        
        self.userId = userId;
        self.blogs = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.apiManager = [UserAPIManager new];
        
        __weak typeof(self) weakSelf = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"BlogTableViewCell" bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.apiManager refreshUserBlogsWithUserId:weakSelf.userId completionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.header endRefreshing];
                
                if (!error) {
                    
                    [weakSelf.blogs removeAllObjects];
                    [weakSelf reloadTableViewWithBlogs:result];
                    [weakSelf.tableView.footer resetNoMoreData];
                }
            }];
        }];
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.apiManager loadModeUserBlogsWithUserId:weakSelf.userId completionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.footer endRefreshing];
                
                if (!error) {
                    [weakSelf reloadTableViewWithBlogs:result];
                } else if (error.code == NetworkErrorNoMoreData) {
                    
                    [weakSelf.tableView showToastWithText:error.domain];
                    [weakSelf.tableView.footer endRefreshingWithNoMoreData];
                }
            }];
        }];
    }
    return self;
}

#pragma mark - Interface

- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHander {
    [self.apiManager refreshUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        if (error) {
//            ... show errorView in tableView
        } else {
            [self reloadTableViewWithBlogs:result];
        }
        
        !completionHander ?: completionHander(error, result);
    }];
}

#pragma mark - UITableViewDataSource && Delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BlogCellHelper *cellHelper = self.blogs[indexPath.row];
    BlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.title = cellHelper.blogTitleText;
    cell.summary = cellHelper.blogSummaryText;
    cell.likeState = cellHelper.isLiked;
    cell.likeCountText = cellHelper.blogLikeCountText;
    cell.shareCountText = cellHelper.blogShareCountText;
    
    __weak typeof(cell) weakCell = cell;
    [cell setDidLikeHandler:^{
        
        if (cellHelper.blog.isLiked) {
            [self.tableView showToastWithText:@"你已经赞过它了~"];
        } else {
            
            [[UserAPIManager new] likeBlogWithBlogId:cellHelper.blog.blogId completionHandler:^(NSError *error, id result) {
                if (error) {
                    [self.tableView showToastWithText:error.domain];
                } else {
                    
                    cellHelper.blog.likeCount += 1;
                    weakCell.likeState = cellHelper.blog.isLiked = YES;
                    weakCell.likeCountText = cellHelper.blogLikeCountText;
                }
            }];
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.VCGenerator) {
        
        UIViewController *targetVC = self.VCGenerator(self.blogs[indexPath.row].blog);
        if (targetVC) {
            [self.tableView.navigationController pushViewController:targetVC animated:YES];
        }
    }
}

#pragma mark - Utils

- (void)reloadTableViewWithBlogs:(NSArray *)blogs {
    
    for (Blog *blog in blogs) {
        [self.blogs addObject:[BlogCellHelper helperWithBlog:blog]];
    }
    [self.tableView reloadData];
}

@end
