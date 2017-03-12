//
//  BlogTableViewCell.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogTableViewCell.h"

#import "UIView+Extension.h"

@interface BlogTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (copy, nonatomic) void(^didLikeHandler)();
@end

@implementation BlogTableViewCell

#pragma mark - Action

- (IBAction)onClickLikeButton:(UIButton *)sender {
    !self.didLikeHandler ?: self.didLikeHandler();
}

#pragma mark - Interface

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSummary:(NSString *)summary {
    self.summaryLabel.text = summary;
}

- (void)setLikeState:(BOOL)isLiked {
    [self.likeButton setTitleColor:isLiked ? [UIColor redColor] : [UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setLikeCountText:(NSString *)likeCountText {
    [self.likeButton setTitle:likeCountText forState:UIControlStateNormal];
}

- (void)setShareCountText:(NSString *)shareCountText {
    [self.shareButton setTitle:shareCountText forState:UIControlStateNormal];
}

@end
