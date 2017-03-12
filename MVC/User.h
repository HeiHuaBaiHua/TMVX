//
//  User.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

- (instancetype)initWithUserId:(NSUInteger)userId;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *summary;
@property (assign, nonatomic) NSUInteger userId;
@property (assign, nonatomic) NSUInteger blogCount;
@property (assign, nonatomic) NSUInteger friendCount;

@end
