//
//  UIView+Controller.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)

- (UIViewController *)viewController {
    
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

- (UINavigationController *)navigationController {
    return self.viewController.navigationController;
}

@end
