//
//  UserInfoController.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/31.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfoView.h"
#import "UserInfoViewModel.h"
@interface UserInfoController : NSObject

//法1
+ (instancetype)instanceWithView:(UserInfoView *)view viewModel:(UserInfoViewModel *)viewModel;

//法2
//+ (instancetype)instanceWithView:(UIView<UserInfoViewProtocl> *)view viewModel:(id<UserInfoViewModelProtocol>)viewModel;

- (UserInfoView *)view;
- (UserInfoViewModel *)viewModel;
//- (UIView<UserInfoViewProtocl> *)view;
//- (id<UserInfoViewModelProtocol> *)viewModel;

- (void)fetchData;
- (void)setOnClickIconCommand:(RACCommand *)onClickIconCommand;
@end
