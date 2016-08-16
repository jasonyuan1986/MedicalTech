//
//  AppDelegate.m
//  MedicalTech
//
//  Created by Jason on 7/1/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftSideViewController.h"
#import "IndexViewController.h"
#import "LoginViewController.h"
#import "LoginNavigationController.h"

@interface AppDelegate () <LoginDelegate, IndexViewDelegate>


@property (nonatomic, strong) LoginNavigationController *loginNavigationController;
@property (nonatomic, strong) MMDrawerController *drawerController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    if (HEADERTOKEN) {
        LeftSideViewController *leftSideViewController = [[LeftSideViewController alloc] init];
        
        IndexViewController *indexViewController = [[IndexViewController alloc] init];
        indexViewController.delegate = self;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:indexViewController];
        navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.0/255.0 green:192.0/255.0 blue:179.0/255.0 alpha:1.0];
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftSideViewController];
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [self.window setRootViewController:self.drawerController];
    } else {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        loginViewController.delegate = self;
        self.loginNavigationController = [[LoginNavigationController alloc] initWithRootViewController:loginViewController];
        
        [self.window setRootViewController:self.loginNavigationController];
    }
    
    return YES;
}

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

#pragma mark - Login delegate

- (void)loginSuccess {
    LeftSideViewController *leftSideViewController = [[LeftSideViewController alloc] init];
    
    IndexViewController *indexViewController = [[IndexViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:indexViewController];
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.0/255.0 green:192.0/255.0 blue:179.0/255.0 alpha:1.0];
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftSideViewController];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.window setRootViewController:self.drawerController];
}

#pragma mark - Index view delegate

- (void)relogin {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.delegate = self;
    self.loginNavigationController = [[LoginNavigationController alloc] initWithRootViewController:loginViewController];
    
    [self.window setRootViewController:self.loginNavigationController];
}

@end
