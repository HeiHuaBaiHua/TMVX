//
//  UIView+Alert.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Alert <NSObject>

- (void)showHUD;
- (void)showHUDWithText:(NSString *)text;
- (void)hideHUD;

- (void)showToastWithText:(NSString *)toastString;
- (void)showToastWithText:(NSString *)toastString positon:(id)positon;
- (void)showToastWithText:(NSString *)toastString afterDelay:(NSTimeInterval)timeInterval;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelAction:(UIAlertAction *)cancelAction confirmAction:(UIAlertAction *)confirmAction;

@end

@interface UIView (Alert)<Alert>
@end

@interface UIViewController (Alert)<Alert>
@end
