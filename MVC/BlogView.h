//
//  BlogView.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlogViewModel.h"
@interface BlogView : NSObject<UITableViewDataSource, UITableViewDelegate>

+ (instancetype)instanceWithViewModel:(BlogViewModel *)viewModel;

- (UITableView *)tableView;

- (RACCommand *)fetchDataCommand;
- (void)setDidSelectedRowCommand:(RACCommand *)didSelectedRowCommand;
@end
