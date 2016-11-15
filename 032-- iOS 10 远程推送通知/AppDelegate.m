//
//  AppDelegate.m
//  032-- iOS 10 远程推送通知
//
//  Created by mac on 16/11/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 获取center
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    // 设置回调
    center.delegate = self;
    
    // 请求用户授权
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) {
            
            NSLog(@"用户允许推送通知");
        } else {
            
            NSLog(@"用户不允许");
        }
        
    }];
    
    // 先注册category
    // 给center设置category
    // 还需要给content设置categoryIdentifier
    UNNotificationAction *textInputAction = [UNTextInputNotificationAction actionWithIdentifier:@"textInput" title:@"文本输入" options:UNNotificationActionOptionForeground textInputButtonTitle:@"说吧" textInputPlaceholder:@"说点什么吧"];
    UNNotificationAction *foregroundAction = [UNNotificationAction actionWithIdentifier:@"foreground" title:@"前台" options:UNNotificationActionOptionForeground];
    UNNotificationAction *destructiveAction = [UNNotificationAction actionWithIdentifier:@"destructive" title:@"毁灭" options:UNNotificationActionOptionDestructive];
    // category
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"吃饭" actions:@[foregroundAction, destructiveAction, textInputAction] intentIdentifiers:@[@"destructive", @"foreground"] options:UNNotificationCategoryOptionCustomDismissAction];
    // 赋值
    [center setNotificationCategories:[NSSet setWithObject:category]];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", deviceToken);
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    // 可以展示通知之前在这里设置通知
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    
}

// 用户点击了通知后调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    // 通过 userInfo 的内容来决定页面跳转或者是进行其他操作
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    // 直接告诉系统你已经完成了所有工作
    
#pragma mark - 关于对action的处理，也是通过这里的判断
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    
    // 判断categoryIdentifier
    if ([categoryIdentifier isEqualToString:@"吃饭"]) {
        
        NSString *actionIdentifier = response.actionIdentifier;
        
        // 判断actionIdentifier
        if ([actionIdentifier isEqualToString:@"textInput"]) {
            
            // 如果用户输入了文本并点击了按钮，才会走到这里
            
        }
        
    }
    
    completionHandler();
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
