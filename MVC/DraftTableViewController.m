//
//  DraftTableViewHelper.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "DraftTableViewController.h"

#import "MJRefresh.h"
#import "DraftTableViewCell.h"

#import "UIView+Alert.h"
#import "DraftCellHelper.h"

@interface DraftTableViewController ()

@property (copy, nonatomic) void(^didSelectedRowHandler)(Draft *);
@property (assign, nonatomic) NSUInteger userId;
@property (strong, nonatomic) UserAPIManager *apiManager;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<DraftCellHelper *> *drafts;

@end

#define RowHeight 44
#define ReuseIdentifier @"DraftTableViewCell"
@implementation DraftTableViewController

+ (instancetype)instanceWithUserId:(NSUInteger)userId {
    return [[DraftTableViewController alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        
        self.userId = userId;
        self.drafts = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.apiManager = [UserAPIManager new];
        
        __weak typeof(self) weakSelf = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"DraftTableViewCell" bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.apiManager refreshUserDraftsWithUserId:weakSelf.userId completionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.header endRefreshing];
                
                if (!error) {
                    
                    [weakSelf.drafts removeAllObjects];
                    [weakSelf reloadTableViewWithDrafts:result];
                    [weakSelf.tableView.footer resetNoMoreData];
                }
            }];
        }];
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.apiManager loadModeUserDraftsWithUserId:weakSelf.userId completionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.footer endRefreshing];
                
                if (!error) {
                    [weakSelf reloadTableViewWithDrafts:result];
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

- (void)fetchData {
    
    [self.apiManager refreshUserDraftsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        if (error) {
            //            ... show errorView in tableView
        } else {
            [self reloadTableViewWithDrafts:result];
        }
    }];
}

#pragma mark - UITableViewDataSource && Delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.drafts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView showAlertWithTitle:@"提示" message:@"确定删除这份草稿?" confirmHandler:^(UIAlertAction *confirmAction) {
           
            [self.tableView showHUD];
            [[UserAPIManager new] deleteDraftWithDraftId:self.drafts[indexPath.row].draft.draftId completionHandler:^(NSError *error, id result) {
                [self.tableView hideHUD];
                
                if (error) {
                    [self.tableView showToastWithText:error.domain];
                } else {
               
                    [self.drafts removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];
                }
            }];
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DraftCellHelper *cellHelper = self.drafts[indexPath.row];
    DraftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.title = cellHelper.darftTitleText;
    cell.summary = cellHelper.draftSummaryText;
    cell.editDate = cellHelper.draftEditDate;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    !self.didSelectedRowHandler ?: self.didSelectedRowHandler(self.drafts[indexPath.row].draft);
}

#pragma mark - Utils

- (void)reloadTableViewWithDrafts:(NSArray *)drafts {
    
    for (Draft *draft in drafts) {
        [self.drafts addObject:[DraftCellHelper helperWithDraft:draft]];
    }
    [self.tableView reloadData];
}

@end
