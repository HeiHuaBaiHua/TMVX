//
//  DraftCellHelper.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Draft.h"

@interface DraftCellHelper : NSObject

+ (instancetype)helperWithDraft:(Draft *)draft;

- (Draft *)draft;

- (NSString *)draftEditDate;
- (NSString *)darftTitleText;
- (NSString *)draftSummaryText;

@end
