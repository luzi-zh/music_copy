//
//  AvatarManager.h
//  网易云仿写
//
//  Created by luzi on 2026/6/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AvatarManager : NSObject
+ (instancetype)sharedManager;
@property (nonatomic, strong) UIImage *avatarImage;
@end

NS_ASSUME_NONNULL_END
