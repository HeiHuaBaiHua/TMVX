//
//  BlogViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogViewController.h"

#import "MJRefresh.h"
#import "BlogViewCell.h"

#import "UIView+Alert.h"
#import "BlogViewPresenter.h"
#import "UIView+Controller.h"

@interface BlogViewController ()<BlogViewPresenterCallBack>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) BlogViewPresenter *presenter;

@end

#define RowHeight 44
#define ReuseIdentifier @"BlogViewCell"
@implementation BlogViewController

+ (instancetype)instanceWithPresenter:(BlogViewPresenter *)presenter {
    return [[BlogViewController alloc] initWithPresenter:presenter];
}

- (instancetype)initWithPresenter:(BlogViewPresenter *)presenter {
    if (self = [super init]) {
        
        self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.presenter = presenter;
        self.presenter.view = self;//将V和P进行绑定(这里因为V是系统的TableView 无法简单的声明一个view属性 所以就绑定到TableView的持有者上面)
        
        __weak typeof(self) weakSelf = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"BlogViewCell" bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.presenter refreshData];
        }];
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.presenter loadMoreData];
        }];
    }
    return self;
}

#pragma mark - BlogViewPresenterCallBack 

- (void)blogViewPresenter:(BlogViewPresenter *)presenter didRefreshDataWithResult:(id)result error:(NSError *)error {
    [self.tableView.header endRefreshing];
    
    if (!error) {
        
        [self.tableView reloadData];
        [self.tableView.footer resetNoMoreData];
    } else if (self.presenter.allDatas.count == 0) {
//        show error view
    }
}

- (void)blogViewPresenter:(BlogViewPresenter *)presenter didLoadMoreDataWithResult:(id)result error:(NSError *)error {
    [self.tableView.footer endRefreshing];
    
    if (!error) {
        [self.tableView reloadData];
    } else if (error.code == NetworkErrorNoMoreData) {
        
        [self.tableView showToastWithText:error.domain];
        [self.tableView.footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.allDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BlogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.presenter = self.presenter.allDatas[indexPath.row];//PV绑定
    
    __weak typeof(cell) weakCell = cell;
    [cell setDidLikeHandler:^{//这里用一个handler是因为点赞失败需要弹框提示, 这个弹框是什么样式或者弹不弹框cell是不知道, 所以把事件传出来在C层处理, 或者你也可以再传到Scene层处理, 这个看具体的业务场景.
        
        //实际的点赞逻辑调用的还是P层实现
        [weakCell.presenter likeBlogWithCompletionHandler:^(NSError *error, id result) {
            !error ?: [weakCell showToastWithText:error.domain];
        }];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(blogViewControllerdidSelectBlog:)]) {
        [self.delegate blogViewControllerdidSelectBlog:self.presenter.allDatas[indexPath.row].blog];
    }
}

@end
