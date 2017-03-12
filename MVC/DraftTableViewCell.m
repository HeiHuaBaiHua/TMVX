//
//  DraftTableViewCell.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "DraftTableViewCell.h"

@interface DraftTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *editDateLabel;

@end

@implementation DraftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSummary:(NSString *)summary {
    self.summaryLabel.text = summary;
}

- (void)setEditDate:(NSString *)editDate {
    self.editDateLabel.text = editDate;
}

@end
