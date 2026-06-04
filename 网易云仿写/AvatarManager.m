//
//  AvatarManager.m
//  网易云仿写
//
//  Created by luzi on 2026/6/2.
//

#import "AvatarManager.h"

@implementation AvatarManager
+ (instancetype)sharedManager {
    static AvatarManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end
