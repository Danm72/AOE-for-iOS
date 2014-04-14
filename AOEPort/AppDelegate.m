//
//  AppDelegate.m
//  Age of Empires Port
//
//  Created by Dan Malone on 04/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "GameViewController.h"
#import "SWRevealViewController.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    GameViewController *topView =  [[GameViewController alloc] init];
//    self.viewController.anchorRightPeekAmount = 100.0;
//    self.viewController.anchorLeftRevealAmount = 250.0;
////    self.viewController = [[ECSlidingViewController alloc] init];
  /*  UIViewController *topViewController = [[UIViewController alloc] init];
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
    UIBarButtonItem *anchorLeftButton = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(anchorLeft)];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:topViewController];
*///    self.window.rootViewController = navigationController;

    [topView.navigationController.view addGestureRecognizer:self.viewController.panGestureRecognizer];
    [topView.navigationController.view addGestureRecognizer:self.viewController.tapGestureRecognizer];

    self.viewController = [[SWRevealViewController alloc] init];
//    topViewController.navigationItem.leftBarButtonItem = anchorRightButton;
//    topViewController.navigationItem.rightBarButtonItem = anchorLeftButton;
////    self.viewController.topViewController = [[UINavigationController alloc] initWithRootViewController:[[GameViewController alloc] init]];
    self.viewController.rearViewController = [[MenuViewController alloc] init];
    self.viewController.frontViewController = topView;


    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;


}

//- (void)anchorRight {
//    [self.viewController anchorTopViewToRightAnimated:YES];
//}
//
//- (void)anchorLeft {
//    [self.viewController anchorTopViewToLeftAnimated:YES];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
