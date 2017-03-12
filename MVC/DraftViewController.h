//
//  DraftViewController.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserAPIManager.h"
#import "DraftViewPresenter.h"
@interface DraftViewController : NSObject<UITableViewDelegate, UITableViewDataSource>

+ (instancetype)instanceWithPresenter:(DraftViewPresenter *)presenter;

- (UITableView *)tableView;
- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHander;

- (void)setDidSelectedRowHandler:(void (^)(Draft *))didSelectedRowHandler;
@end
