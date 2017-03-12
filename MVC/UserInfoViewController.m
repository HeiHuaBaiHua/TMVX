//
//  UserInfoViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "UserInfoViewController.h"

#import "UIView+Controller.h"

#import "User.h"
@interface UserInfoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *blogCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendCountLabel;

@property (strong, nonatomic) User *user;
@property (assign, nonatomic) NSUInteger userId;
@property (copy, nonatomic) ViewControllerGenerator VCGenerator;
@end

@implementation UserInfoViewController

+ (instancetype)instanceWithUserId:(NSUInteger)userId {
    UserInfoViewController *vc = [UserInfoViewController new];
    vc.userId = userId;
    return vc;
}

+ (CGFloat)viewHeight {
    return 160;
}

#pragma mark - Inferface

- (void)fetchData {
    
    [[UserAPIManager new] fetchUserInfoWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        if (error) {
//            ... show error view in userInfoView
        } else {
            
            User *user = self.user = result;
            
            self.nameLabel.text = user.name;
            self.summaryLabel.text = [NSString stringWithFormat:@"个人简介: %@", user.summary];
            self.blogCountLabel.text = [NSString stringWithFormat:@"作品: %ld", user.blogCount];
            self.friendCountLabel.text = [NSString stringWithFormat:@"好友: %ld", user.friendCount];
            [self.iconButton setImage:[UIImage imageNamed:user.icon] forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - Action

- (IBAction)onClickIconButton:(UIButton *)sender {
    
    if (self.VCGenerator) {
        
        UIViewController *targetVC = self.VCGenerator(self.user);
        if (targetVC) {
            [self.parentViewController.navigationController pushViewController:targetVC animated:YES];
        }
    }
}

@end
