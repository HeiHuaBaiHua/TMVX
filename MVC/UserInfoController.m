//
//  UserInfoController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/31.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "UserInfoController.h"

@interface UserInfoController ()

//法1
@property (strong, nonatomic) UserInfoView *view;
@property (strong, nonatomic) UserInfoViewModel *viewModel;

//法2
//@property (strong, nonatomic) UIView<UserInfoViewProtocl> *view;
//@property (strong, nonatomic) id<UserInfoViewModelProtocol> viewModel;

@property (strong, nonatomic) RACCommand *onClickIconCommand;
@end

@implementation UserInfoController


+ (instancetype)instanceWithView:(UserInfoView *)view viewModel:(UserInfoViewModel *)viewModel {
    if (view == nil || viewModel == nil) { return nil; }
    
    return [[UserInfoController alloc] initWithView:view viewModel:viewModel];
}

//- (instancetype)initWithView:(UIView<UserInfoViewProtocl> *)view viewModel:(id<UserInfoViewModelProtocol>)viewModel
- (instancetype)initWithView:(UserInfoView *)view viewModel:(UserInfoViewModel *)viewModel {
    if (self = [super init]) {
        self.view = view;
        self.viewModel = viewModel;
        
        [self bind];
    }
    return self;
}

- (void)bind {
    
    RAC(self.view.nameLabel, text) = RACObserve(self, viewModel.name);
    RAC(self.view.summaryLabel, text) = RACObserve(self, viewModel.summary);
    RAC(self.view.blogCountLabel, text) = RACObserve(self, viewModel.blogCount);
    RAC(self.view.friendCountLabel, text) = RACObserve(self, viewModel.friendCount);
    @weakify(self);
    [RACObserve(self, viewModel.icon) subscribeNext:^(UIImage *icon) {
        @strongify(self);
        [self.view.iconButton setImage:icon forState:UIControlStateNormal];
    }];
    [[self.view.iconButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.onClickIconCommand execute:self.viewModel.user];
    }];
}

- (void)fetchData {
    
    [[[self.viewModel fetchUserInfoCommand] execute:nil] subscribeError:^(NSError *error) {
        //show error view
    } completed:^{
        //do completed
    }];
}

@end
