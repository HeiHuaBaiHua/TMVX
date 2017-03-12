//
//  UserInfoViewController.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserAPIManager.h"
@interface UserInfoViewController : UIViewController

+ (CGFloat)viewHeight;
+ (instancetype)instanceWithUserId:(NSUInteger)userId;

- (void)fetchData;
- (void)setVCGenerator:(ViewControllerGenerator)VCGenerator;
@end
