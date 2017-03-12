//
//  BlogCell.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlogCellViewModel.h"
@interface BlogCell : UITableViewCell

@property (strong, nonatomic) BlogCellViewModel *viewModel;

@end
