//
//  DraftViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "DraftViewController.h"

#import "MJRefresh.h"
#import "DraftViewCell.h"

#import "UIView+Alert.h"
#import "DraftViewPresenter.h"
#import "UIView+Controller.h"

@interface DraftViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DraftViewPresenter *presenter;

@property (copy, nonatomic) void(^didSelectedRowHandler)(Draft *);
@end

#define RowHeight 44
#define ReuseIdentifier @"DraftViewCell"
@implementation DraftViewController

+ (instancetype)instanceWithPresenter:(DraftViewPresenter *)presenter {
    return [[DraftViewController alloc] initWithPresenter:presenter];
}

- (instancetype)initWithPresenter:(DraftViewPresenter *)presenter {
    if (self = [super init]) {
        
        self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.presenter = presenter;
        
        __weak typeof(self) weakSelf = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"DraftViewCell" bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.presenter refreshDataWithCompletionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.header endRefreshing];
                
                if (!error) {
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.footer resetNoMoreData];
                }
            }];
        }];
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.presenter loadMoreDataWithCompletionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.footer endRefreshing];
                
                if (!error) {
                    [weakSelf.tableView reloadData];
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
    [self.presenter refreshDataWithCompletionHandler:^(NSError *error, id result) {
        
        if (!error) {
            [self.tableView reloadData];
        } else {
            //        show error view
        }
        !completionHander ?: completionHander(error, result);
    }];
}

#pragma mark - UITableViewDataSource && Delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.allDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView showAlertWithTitle:@"提示" message:@"确定删除这份草稿?" confirmHandler:^(UIAlertAction *confirmAction) {
            
            [self.tableView showHUD];//因为现在M归P管, 任何涉及到到M层变动的操作都必须经过P层
            [self.presenter deleteDraftAtIndex:indexPath.row completionHandler:^(NSError *error, id result) {
                [self.tableView hideHUD];
                
                error ? [self.tableView showToastWithText:error.domain] : [self.tableView reloadData];
            }];
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DraftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.presenter = self.presenter.allDatas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    !self.didSelectedRowHandler ?: self.didSelectedRowHandler(self.presenter.allDatas[indexPath.row].draft);
}

@end
