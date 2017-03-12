//
//  UserViewController.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LoginUserId 123

@interface UserViewController : UIViewController

+ (instancetype)instanceWithUserId:(NSUInteger)userId;

@end
