//
//  UIResponder+Router.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routeEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [self.nextResponder routeEvent:eventName userInfo:userInfo];
}

@end
