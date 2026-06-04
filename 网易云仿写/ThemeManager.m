// ThemeManager.m
#import "ThemeManager.h"

@implementation ThemeManager

+ (instancetype)sharedManager {
    static ThemeManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ThemeManager alloc] init];
        manager.darkModeEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"DarkModeEnabled"];
    });
    return manager;
}

- (void)changeTheme:(BOOL)isDark {
    // 1. 保存新状态
    _darkModeEnabled = isDark;
    
    // 2. 存进本地（重启APP不丢失）
    [[NSUserDefaults standardUserDefaults] setBool:isDark forKey:@"DarkModeEnabled"];
    
    // 3. 发通知：告诉所有界面刷新颜色
    [[NSNotificationCenter defaultCenter] postNotificationName:@"THEME_CHANGED" object:nil];
}

// 背景颜色
- (UIColor *)backgroundColor {
    if (self.darkModeEnabled) {
        return [UIColor blackColor];
    } else {
        return [UIColor whiteColor];
    }
}

// 文字颜色
- (UIColor *)textColor {
    if (self.darkModeEnabled) {
        return [UIColor whiteColor];
    } else {
        return [UIColor blackColor];
    }
}
@end
