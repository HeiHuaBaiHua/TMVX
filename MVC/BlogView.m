//
//  BlogView.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogView.h"

#import "MJRefresh.h"
#import "BlogCell.h"

#import "UIView+Alert.h"
#import "BlogViewPresenter.h"
#import "UIView+Controller.h"

@interface BlogView ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) BlogViewModel *viewModel;

@property (strong, nonatomic) RACCommand *fetchDataCommand;
@property (strong, nonatomic) RACCommand *didSelectedRowCommand;
@end

#define RowHeight 44
#define ReuseIdentifier @"BlogCell"
@implementation BlogView

+ (instancetype)instanceWithViewModel:(BlogViewModel *)viewModel {
    return [[BlogView alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(BlogViewModel *)viewModel {
    if (self = [super init]) {
        
        self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.viewModel = viewModel;
        
        @weakify(self);
        self.fetchDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            RACSubject *subject = [RACSubject subject];
            [self.viewModel.refreshDataSignal subscribeError:^(NSError *error) {
                
//                show error view
                [subject sendError:error];
            } completed:^{
                
                [self.tableView reloadData];
                [subject sendCompleted];
            }];
            return subject;
        }];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"BlogCell" bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            
            [self.viewModel.refreshDataSignal subscribeError:^(NSError *error) {
                [self.tableView.header endRefreshing];
            } completed:^{
                
                [self.tableView reloadData];
                [self.tableView.header endRefreshing];
                [self.tableView.footer resetNoMoreData];
            }];
        }];
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            
            [self.viewModel.loadMoreDataSignal subscribeError:^(NSError *error) {
                
                [self.tableView.footer endRefreshing];
                [self.tableView showToastWithText:error.domain];
                [self.tableView.footer endRefreshingWithNoMoreData];
            } completed:^{
                
                [self.tableView reloadData];
                [self.tableView.footer endRefreshing];
            }];
        }];
    }
    return self;
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.allDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BlogCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.viewModel = self.viewModel.allDatas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.didSelectedRowCommand execute:self.viewModel.allDatas[indexPath.row].blog];
}

@end
