//
//  ViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "ViewController.h"

#import "UserViewController.h"
#import "MVPUserViewController.h"
#import "MVVMUserViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)MVC:(UIButton *)sender {
    [self.navigationController pushViewController:[UserViewController instanceWithUserId:sender.tag] animated:YES];
}

- (IBAction)MVP:(UIButton *)sender {
    [self.navigationController pushViewController:[MVPUserViewController instanceWithUserId:123] animated:YES];
}

- (IBAction)MVVM:(UIButton *)sender {
    [self.navigationController pushViewController:[MVVMUserViewController instanceWithUserId:123] animated:YES];
}
@end
