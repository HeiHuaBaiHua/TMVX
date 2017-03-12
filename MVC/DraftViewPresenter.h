//
//  DraftViewPresenter.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserAPIManager.h"
#import "DraftCellPresenter.h"
@interface DraftViewPresenter : NSObject

+ (instancetype)presenterWithUserId:(NSUInteger)userId;

- (NSArray<DraftCellPresenter *> *)allDatas;

- (void)refreshDataWithCompletionHandler:(NetworkCompletionHandler)completionHander;
- (void)loadMoreDataWithCompletionHandler:(NetworkCompletionHandler)completionHander;
- (void)deleteDraftAtIndex:(NSUInteger)index completionHandler:(NetworkCompletionHandler)completionHander;
@end
