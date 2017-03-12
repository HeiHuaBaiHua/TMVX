//
//  BlogViewCell.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlogCellPresenter.h"
@interface BlogViewCell : UITableViewCell

@property (strong, nonatomic) BlogCellPresenter *presenter;

- (void)setDidLikeHandler:(void (^)())didLikeHandler;
@end
