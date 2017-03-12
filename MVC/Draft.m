//
//  Draft.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "Draft.h"

@implementation Draft

- (instancetype)initWithDraftId:(NSUInteger)draftId {
    
    self.draftId = draftId;
    self.draftTitle = [NSString stringWithFormat:@"draftTitle%ld", draftId];
    self.draftSummary = [NSString stringWithFormat:@"draftSummary%ld", draftId];
    self.editDate = [[NSDate date] timeIntervalSince1970] + arc4random() % 200;
    
    return self;
}

@end
