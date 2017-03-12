//
//  BlogViewModel.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserAPIManager.h"
#import "BlogCellViewModel.h"
@interface BlogViewModel : NSObject

+ (instancetype)viewModelWithUserId:(NSUInteger)userId;

- (NSArray<BlogCellViewModel *> *)allDatas;

- (RACSignal *)refreshDataSignal;
- (RACSignal *)loadMoreDataSignal;

@end
