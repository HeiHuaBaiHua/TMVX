//
//  Draft.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Draft : NSObject

- (instancetype)initWithDraftId:(NSUInteger)draftId;

@property (copy, nonatomic) NSString *draftTitle;
@property (copy, nonatomic) NSString *draftSummary;
@property (assign, nonatomic) NSUInteger draftId;
@property (assign, nonatomic) NSUInteger editDate;

@end
