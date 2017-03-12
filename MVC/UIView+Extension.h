//
//  UIView+Extension.m
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define NAVBAR_HEIGHT 64

#define OneInterval 10

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenBoundsWithoutTopBar CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_TOP_HEIGHT)
#define ScreenBoundsStartWithTopBar CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_TOP_HEIGHT)

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

- (void)disableAWhile;
- (void)disableAWhile:(NSTimeInterval)time;

@end
