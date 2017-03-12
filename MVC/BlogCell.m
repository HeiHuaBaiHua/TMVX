//
//  BlogCell.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "BlogCell.h"

#import "UIResponder+Router.h"

@interface BlogCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation BlogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    @weakify(self);
    RAC(self.titleLabel, text) = RACObserve(self, viewModel.blogTitleText);
    RAC(self.summaryLabel, text) = RACObserve(self, viewModel.blogSummaryText);
    RAC(self.likeButton, selected) = [RACObserve(self, viewModel.isLiked) ignore:nil];
    [RACObserve(self, viewModel.blogLikeCount) subscribeNext:^(NSString *title) {
        @strongify(self);
        [self.likeButton setTitle:title forState:UIControlStateNormal];
    }];
    [RACObserve(self, viewModel.blogShareCount) subscribeNext:^(NSString *title) {
        @strongify(self);
        [self.shareButton setTitle:title forState:UIControlStateNormal];
    }];
    
}

- (IBAction)onClickLikeButton:(UIButton *)sender {
    [self routeEvent:LikeBlogEvent userInfo:@{kCellViewModel : self.viewModel}];
}

@end
