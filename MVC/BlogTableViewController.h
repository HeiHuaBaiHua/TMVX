//
//  BlogTableViewHelper.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserAPIManager.h"
@interface BlogTableViewController : NSObject<UITableViewDelegate, UITableViewDataSource>

+ (instancetype)instanceWithUserId:(NSUInteger)userId;

- (UITableView *)tableView;
- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHander;
- (void)setVCGenerator:(ViewControllerGenerator)VCGenerator;

@end
