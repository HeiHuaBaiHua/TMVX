//
//  SceneX.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "SceneX.h"

#import "UIView+Alert.h"
#import "UIView+Extension.h"
#import "BlogTableViewController.h"

@interface SceneX ()

@property (strong, nonatomic) BlogTableViewController *blogVC;

@end

@implementation SceneX

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blogVC = [BlogTableViewController instanceWithUserId:999];
    self.blogVC.tableView.frame = ScreenBounds;
    [self.view addSubview:self.blogVC.tableView];
    
    [self showHUD];
    [self.blogVC fetchDataWithCompletionHandler:^(NSError *error, id result) {
        [self hideHUD];
    }];
}


@end
