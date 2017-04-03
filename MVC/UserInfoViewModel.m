//
//  UserInfoViewModel.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/31.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "User.h"

#import "UserAPIManager.h"
#import "UserInfoViewModel.h"

@interface UserInfoViewModel ()

@property (strong, nonatomic) UIImage *icon;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *blogCount;
@property (copy, nonatomic) NSString *friendCount;

@property (strong, nonatomic) User *user;
@property (assign, nonatomic) NSUInteger userId;

@end

@implementation UserInfoViewModel

+ (instancetype)viewModelWithUserId:(NSUInteger)userId {
    UserInfoViewModel *viewModel = [UserInfoViewModel new];
    viewModel.userId = userId;
    return viewModel;
}

- (RACCommand *)fetchUserInfoCommand {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[self fetchUserInfoSignal] doNext:^(User *user) {
            
            self.user = user;
            self.icon = [UIImage imageNamed:user.icon ?: @"icon0"];
            self.name = user.name.length > 0 ? user.name : @"匿名";
            self.summary = [NSString stringWithFormat:@"个人简介: %@", user.summary.length > 0 ? user.summary : @"这个人很懒, 什么也没有写~"];
            self.blogCount = [NSString stringWithFormat:@"作品: %ld", user.blogCount];
            self.friendCount = [NSString stringWithFormat:@"好友: %ld", user.friendCount];
        }];
    }];
}

- (RACSignal *)fetchUserInfoSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[UserAPIManager new] fetchUserInfoWithUserId:self.user.userId completionHandler:^(NSError *error, id result) {
            
            if (!error) {
                
                [subscriber sendNext:result];
                [subscriber sendCompleted];
            } else {
             
//                如果API没做错误格式化 在此处格式化
//                switch (error.code) {
//                    case xxx: error = xxx
//                    case yyy: error = yyy
//
//                    default:break;
//                }
                [subscriber sendError:error];
            }
        }];
        return nil;
    }];
}

@end
