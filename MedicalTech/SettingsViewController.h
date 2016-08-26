//
//  SettingsViewController.h
//  MedicalTech
//
//  Created by Jason on 8/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingViewDelegate <NSObject>

- (void)logoutSuccess;
- (void)goToResetPassword;

@end

@interface SettingsViewController : UIViewController

@property (assign, nonatomic) id<SettingViewDelegate> delegate;

@end
