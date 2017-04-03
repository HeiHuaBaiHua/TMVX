//
//  UserInfoView.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/31.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoViewProtocl <NSObject>

- (UIButton *)iconButton;
- (UILabel *)nameLabel;
- (UILabel *)summaryLabel;
- (UILabel *)blogCountLabel;
- (UILabel *)friendCountLabel;

@end

@interface UserInfoView : UIView/**<UserInfoViewProtocl>*/

- (UIButton *)iconButton;
- (UILabel *)nameLabel;
- (UILabel *)summaryLabel;
- (UILabel *)blogCountLabel;
- (UILabel *)friendCountLabel;

@end
