//
//  DraftViewCell.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "DraftViewCell.h"

@interface DraftViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *editDateLabel;
@end

@implementation DraftViewCell

- (void)setPresenter:(DraftCellPresenter *)presenter {
    _presenter = presenter;
    
    self.titleLabel.text = presenter.darftTitleText;
    self.summaryLabel.text = presenter.draftSummaryText;
    self.editDateLabel.text = presenter.draftEditDate;
}

@end
