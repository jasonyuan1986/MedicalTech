//
//  AppDelegate.m
//  MedicalTech
//
//  Created by Jason on 7/1/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftSideViewController.h"
#import "SettingsViewController.h"
#import "MyCourseViewController.h"
#import "InboxViewController.h"
#import "IndexViewController.h"
#import "LoginViewController.h"
#import "ResetPasswordViewController.h"
#import "LoginNavigationController.h"
#import "MainNavigationController.h"

@interface AppDelegate () <LoginDelegate, LeftSideViewDelegate, SettingViewDelegate>


@property (nonatomic, strong) LoginNavigationController *loginNavigationController;
@property (nonatomic, strong) LoginViewController *loginViewController;
@property (nonatomic, strong) ResetPasswordViewController *resetPasswordViewController;
@property (nonatomic, strong) LeftSideViewController *leftSideViewController;
@property (nonatomic, strong) SettingsViewController *settingsViewController;
@property (nonatomic, strong) InboxViewController *inboxViewController;
@property (nonatomic, strong) MyCourseViewController *myCourseViewController;
@property (nonatomic, strong) MainNavigationController *mainNavigationController;
@property (nonatomic, strong) IndexViewController *indexViewController;
@property (nonatomic, strong) MMDrawerController *drawerController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    if (HEADERTOKEN) {
        self.leftSideViewController = [[LeftSideViewController alloc] init];
        self.leftSideViewController.delegate = self;
        
        self.indexViewController = [[IndexViewController alloc] init];
        
        self.mainNavigationController = [[MainNavigationController alloc] initWithRootViewController:self.indexViewController];
        
        self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.mainNavigationController leftDrawerViewController:self.leftSideViewController];
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [self.window setRootViewController:self.drawerController];
    } else {
        self.loginViewController = [[LoginViewController alloc] init];
        self.loginViewController.delegate = self;
        self.loginNavigationController = [[LoginNavigationController alloc] initWithRootViewController:self.loginViewController];
        
        [self.window setRootViewController:self.loginNavigationController];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relogin:) name:@"LOGINTIMEOUT" object:nil];
    
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
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)relogin:(id)sender {
    if (self.loginNavigationController) {
        [self.window setRootViewController:self.loginNavigationController];
    } else {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        loginViewController.delegate = self;
        self.loginNavigationController = [[LoginNavigationController alloc] initWithRootViewController:loginViewController];
        
        [self.window setRootViewController:self.loginNavigationController];
    }
}

#pragma mark - Login delegate

- (void)loginSuccess {
    if (self.drawerController) {
        [self.window setRootViewController:self.drawerController];
    } else {
        self.leftSideViewController = [[LeftSideViewController alloc] init];
        self.leftSideViewController.delegate = self;
        
        self.indexViewController = [[IndexViewController alloc] init];
        
        self.mainNavigationController = [[MainNavigationController alloc] initWithRootViewController:self.indexViewController];
        
        self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.mainNavigationController leftDrawerViewController:self.leftSideViewController];
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [self.window setRootViewController:self.drawerController];
    }
}

#pragma mark - LeftSideViewDelegate

- (void)goToInbox {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.mainNavigationController.topViewController.navigationItem.backBarButtonItem = barButtonItem;
    if (self.inboxViewController) {
        [self.mainNavigationController.topViewController.navigationController pushViewController:self.settingsViewController animated:YES];
    } else {
        self.inboxViewController = [[InboxViewController alloc] init];
//        self.inboxViewController.delegate = self;
        [self.mainNavigationController.topViewController.navigationController pushViewController:self.inboxViewController animated:YES];
    }
    [self.drawerController closeDrawerAnimated:YES completion:nil];
}

- (void)goToSettings {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.mainNavigationController.topViewController.navigationItem.backBarButtonItem = barButtonItem;
    if (self.settingsViewController) {
        [self.mainNavigationController.topViewController.navigationController pushViewController:self.settingsViewController animated:YES];
    } else {
        self.settingsViewController = [[SettingsViewController alloc] init];
        self.settingsViewController.delegate = self;
        [self.mainNavigationController.topViewController.navigationController pushViewController:self.settingsViewController animated:YES];
    }
    [self.drawerController closeDrawerAnimated:YES completion:nil];
}

- (void)goToMyCourse {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.mainNavigationController.topViewController.navigationItem.backBarButtonItem = barButtonItem;
    if (self.myCourseViewController) {
        [self.mainNavigationController.topViewController.navigationController pushViewController:self.myCourseViewController animated:YES];
    } else {
        self.myCourseViewController = [[MyCourseViewController alloc] init];
        [self.mainNavigationController.topViewController.navigationController pushViewController:self.myCourseViewController animated:YES];
    }
    [self.drawerController closeDrawerAnimated:YES completion:nil];
}

#pragma mark - SettingViewDelegate

- (void)logoutSuccess {
    if (self.loginNavigationController) {
        [self.window setRootViewController:self.loginNavigationController];
    } else {
        self.loginViewController = [[LoginViewController alloc] init];
        self.loginViewController.delegate = self;
        self.loginNavigationController = [[LoginNavigationController alloc] initWithRootViewController:self.loginViewController];
        
        [self.window setRootViewController:self.loginNavigationController];
    }
}

- (void)goToResetPassword {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.mainNavigationController.topViewController.navigationItem.backBarButtonItem = barButtonItem;
    if (self.resetPasswordViewController) {
        [self.mainNavigationController.topViewController.navigationController pushViewController:self.resetPasswordViewController animated:YES];
    } else {
        self.resetPasswordViewController = [[ResetPasswordViewController alloc] init];
        [self.mainNavigationController.topViewController.navigationController pushViewController:self.resetPasswordViewController animated:YES];
    }
    [self.drawerController closeDrawerAnimated:YES completion:nil];
}

@end
