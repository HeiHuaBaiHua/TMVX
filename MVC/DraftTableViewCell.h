//
//  DraftTableViewCell.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraftTableViewCell : UITableViewCell

- (void)setTitle:(NSString *)title;
- (void)setSummary:(NSString *)summary;
- (void)setEditDate:(NSString *)editDate;

@end
