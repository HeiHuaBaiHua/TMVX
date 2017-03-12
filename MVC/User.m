//
//  User.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUserId:(NSUInteger)userId {
    
    self.name = [NSString stringWithFormat:@"user%lu",userId];
    self.icon = [NSString stringWithFormat:@"icon%lu.png", userId % 2];
    self.userId = userId;
    self.summary = [NSString stringWithFormat:@"userSummary%ld", userId];
    self.blogCount = userId + 8;
    self.friendCount = userId + 10;
    return self;
}

@end
