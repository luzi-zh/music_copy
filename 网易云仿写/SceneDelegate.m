//
//  SceneDelegate.m
//  网易云仿写
//
//  Created by luzi on 2026/4/28.
//

#import "SceneDelegate.h"
#import "TuiJian.h"
#import "ManYou.h"
#import "WoDe.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    self.window.frame = [UIScreen mainScreen].bounds;
    TuiJian* vc1 = [[TuiJian alloc] init];
    ManYou* vc2 = [[ManYou alloc] init];
    WoDe* vc4 = [[WoDe alloc] init];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    //UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    UIImage *(^origImg)(NSString *) = ^UIImage *(NSString *name) {
            return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        };

        // ------------ nav1 推荐 ------------
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                    image:origImg(@"tuijian")
                                                    selectedImage:origImg(@"tuijian")];
    nav1.tabBarItem.selectedImage = [origImg(@"tuijian") imageWithTintColor:[UIColor redColor]];

        // ------------ nav2 漫游 ------------
    //origImg 就是锁住图片原色，不写图标必变色、样式乱掉。
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"漫游"
                                                        image:origImg(@"manyou")
                                                    selectedImage:origImg(@"manyou")];
    nav2.tabBarItem.selectedImage = [origImg(@"manyou") imageWithTintColor:[UIColor redColor]];

        // ------------ nav4 我的 ------------
    nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                    image:origImg(@"person")
                                                    selectedImage:origImg(@"person")];
    nav4.tabBarItem.selectedImage = [origImg(@"person") imageWithTintColor:[UIColor redColor]];
    
    
    
    UITabBarController* tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = @[nav1,nav2,nav4];
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
