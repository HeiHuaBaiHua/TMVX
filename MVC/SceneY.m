//
//  SceneY.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "SceneY.h"

#import "UIView+Extension.h"
#import "DraftTableViewController.h"

@interface SceneY ()

@property (strong, nonatomic) DraftTableViewController *draftVC;

@end

@implementation SceneY

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.draftVC = [DraftTableViewController instanceWithUserId:999];
    self.draftVC.tableView.frame = ScreenBounds;
    [self.view addSubview:self.draftVC.tableView];
    [self.draftVC fetchData];
}

@end
