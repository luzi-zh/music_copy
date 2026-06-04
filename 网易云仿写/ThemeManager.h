// ThemeManager.h
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemeManager : NSObject

@property (nonatomic, assign) BOOL darkModeEnabled;

+ (instancetype)sharedManager;

-(void)changeTheme:(BOOL)isDark;

// 返回动态颜色
- (UIColor *)backgroundColor;
- (UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
