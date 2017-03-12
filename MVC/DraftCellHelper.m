//
//  DraftCellHelper.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "DraftCellHelper.h"

@interface DraftCellHelper ()

@property (strong, nonatomic) Draft *draft;

@end

@implementation DraftCellHelper

+ (instancetype)helperWithDraft:(Draft *)draft {//懒
    DraftCellHelper *helper = [DraftCellHelper new];
    helper.draft = draft;
    return helper;
}

- (NSString *)draftEditDate {
    
    NSUInteger date = self.draft.editDate > 0 ? self.draft.editDate : [[NSDate date] timeIntervalSince1970];
    return [[NSDate dateWithTimeIntervalSince1970:date] description];
}

- (NSString *)darftTitleText {
    return self.draft.draftTitle.length > 0 ? self.draft.draftTitle : @"未命名";
}

- (NSString *)draftSummaryText {
    return self.draft.draftSummary.length > 0 ? [NSString stringWithFormat:@"摘要: %@", self.draft.draftSummary] : @"写点什么吧~";
}

@end
