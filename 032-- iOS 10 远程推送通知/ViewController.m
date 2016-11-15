//
//  ViewController.m
//  032-- iOS 10 远程推送通知
//
//  Created by mac on 16/11/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
}


# pragma mark - 还是本地推送!!!!!!!!!!!!!!!!!!!!!!!
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 创建content
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"内地和粉底";
    content.body = @"京东看佛教恩对方立刻开纠纷";
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"name" : @"guxuefei", @"age" : @20};
    
    // 设置categoryIdentifier，用于输入文字、关闭、进入等
    content.categoryIdentifier = @"吃饭";
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.0 repeats:NO];
    // 创建远程推送通知请求，标识符可以用来管理通知，可以取消、更新、移除通知
    // 这些管理，都只是针对本地推送，远程推送还不能这样做
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"好吧" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        NSLog(@"推送成功");
        
    }];
    
    // 移除还未展示的通知
//    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"好吧"]];
    
    // 移除已经展示的通知
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[@"好吧"]];
//    });
    // 更新通知，不管有没有已经展示，都可以进行更新，只需要传入相同identifiers的新的请求
    // 多次推送同一标识符的通知即可进行更新
    
    
}

@end
