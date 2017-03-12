//
//  DetailViewController.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "DetailViewController.h"

#import "User.h"
#import "Blog.h"
#import "Draft.h"

#import "SceneX.h"
#import "SceneY.h"
#import "UIView+Extension.h"

@implementation UserDetailViewController

+ (instancetype)instanceWithUser:(User *)user {
    return [[UserDetailViewController alloc] initWithWithUser:user];
}

- (instancetype)initWithWithUser:(User *)user {
    if (self = [super init]) {
        
        self.title = user.name;
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end

@implementation BlogDetailViewController

+ (instancetype)instanceWithBlog:(Blog *)blog {
    return [[BlogDetailViewController alloc] initWithWithBlog:blog];
}

- (instancetype)initWithWithBlog:(Blog *)blog {
    if (self = [super init]) {
        
        self.title = blog.blogTitle;
        self.view.backgroundColor = [UIColor redColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 50)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"SceneX" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toSceneX) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return self;
}

- (void)toSceneX {
    [self.navigationController pushViewController:[SceneX new] animated:YES];
}

@end

@implementation DraftDetailViewController

+ (instancetype)instanceWithDraft:(Draft *)draft {
    return [[DraftDetailViewController alloc] initWithDraft:draft];
}

- (instancetype)initWithDraft:(Draft *)draft {
    if (self = [super init]) {
        
        self.title = draft.draftTitle;
        self.view.backgroundColor = [UIColor blueColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 50)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"SceneY" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toSceneY) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return self;
}

- (void)toSceneY {
    [self.navigationController pushViewController:[SceneY new] animated:YES];
}

@end
