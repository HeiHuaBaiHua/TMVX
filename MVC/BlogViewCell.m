//
//  BlogViewCell.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "UIView+Extension.h"
#import "BlogViewCell.h"

@interface BlogViewCell ()<BlogCellPresenterCallBack>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (copy, nonatomic) void(^didLikeHandler)();
@end

@implementation BlogViewCell

#pragma mark - BlogCellPresenterCallBack

- (void)blogPresenterDidUpdateLikeState:(BlogCellPresenter *)presenter {
    
    [self.likeButton setTitle:presenter.blogLikeCountText forState:UIControlStateNormal];
    [self.likeButton setTitleColor:presenter.isLiked ? [UIColor redColor] : [UIColor blackColor] forState:UIControlStateNormal];
}

- (void)blogPresenterDidUpdateShareState:(BlogCellPresenter *)presenter {
    [self.shareButton setTitle:presenter.blogShareCountText forState:UIControlStateNormal];
}


#pragma mark - Action

- (IBAction)onClickLikeButton:(UIButton *)sender {
    !self.didLikeHandler ?: self.didLikeHandler();
}

#pragma mark - Setter

- (void)setPresenter:(BlogCellPresenter *)presenter {
    _presenter = presenter;
    
    presenter.view = self;
    self.titleLabel.text = presenter.blogTitleText;
    self.summaryLabel.text = presenter.blogSummaryText;
    self.likeButton.selected = presenter.isLiked;
    [self.likeButton setTitle:presenter.blogLikeCountText forState:UIControlStateNormal];
    [self.shareButton setTitle:presenter.blogShareCountText forState:UIControlStateNormal];
}

@end
