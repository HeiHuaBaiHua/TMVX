//
//  DraftCellPresenter.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/11.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "DraftCellPresenter.h"

@interface DraftCellPresenter ()

@property (strong, nonatomic) Draft *draft;

@end

@implementation DraftCellPresenter

+ (instancetype)presenterWithDraft:(Draft *)draft {//懒
    DraftCellPresenter *presenter = [DraftCellPresenter new];
    presenter.draft = draft;
    return presenter;
}

#pragma mark - Command

- (void)deleteDraftWithCompletionHandler:(NetworkCompletionHandler)completionHandler {
    [[UserAPIManager new] deleteDraftWithDraftId:self.draft.draftId completionHandler:completionHandler];
}

#pragma mark - Format

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
