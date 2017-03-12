//
//  DraftCellPresenter.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Draft.h"
#import "UserAPIManager.h"
@interface DraftCellPresenter : NSObject

+ (instancetype)presenterWithDraft:(Draft *)draft;

- (Draft *)draft;

- (NSString *)draftEditDate;
- (NSString *)darftTitleText;
- (NSString *)draftSummaryText;

- (void)deleteDraftWithCompletionHandler:(NetworkCompletionHandler)completionHandler;
@end
