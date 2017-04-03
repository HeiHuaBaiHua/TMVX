//
//  UserInfoViewModel.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/31.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
#import "ReactiveCocoa.h"

@protocol UserInfoViewModelProtocol <NSObject>

- (User *)user;
- (RACCommand *)fetchUserInfoCommand;

- (UIImage *)icon;
- (NSString *)name;
- (NSString *)summary;
- (NSString *)blogCount;
- (NSString *)friendCount;

@end

@interface UserInfoViewModel : NSObject/**<UserInfoViewModelProtocol>*/

+ (instancetype)viewModelWithUserId:(NSUInteger)userId;

- (User *)user;
- (RACCommand *)fetchUserInfoCommand;

- (UIImage *)icon;
- (NSString *)name;
- (NSString *)summary;
- (NSString *)blogCount;
- (NSString *)friendCount;

@end
