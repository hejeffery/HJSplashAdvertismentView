//
//  AppDelegate.m
//  HJSplashAdvertismentView
//
//  Created by HeJeffery on 2017/3/9.
//  Copyright © 2017年 HeJeffery. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#import "HJSplashAdvertisment.h"

@interface AppDelegate () <HJSplashAdvertismentViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[TestViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    HJSplashAdvertismentModel *splashAdvertismentModel = [[HJSplashAdvertismentModel alloc] init];
    splashAdvertismentModel.imageURL = @"http://gb.cri.cn/mmsource/images/2005/08/04/pa050804100.jpg";
    HJSplashAdvertismentView *splashView = [[HJSplashAdvertismentView alloc] init];
    splashView.timeDuration = 3.0;
    splashView.splashAdvertismentModel = splashAdvertismentModel;
    splashView.delegate = self;
    splashView.direction = LowerRightDirection;
    [splashView showInView:self.window];
    return YES;
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

#pragma mark - HJSplashAdvertismentViewDelegate
- (void)splashAdvertismentView:(HJSplashAdvertismentView *)splashAdvertismentView
             imageViewDidClick:(UIImageView *)imageView {
    // Do Nothing
}



@end
