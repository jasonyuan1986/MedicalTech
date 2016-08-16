//
//  LoginViewController.h
//  MedicalTech
//
//  Created by Jason on 7/27/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>

- (void)loginSuccess;

@end

@interface LoginViewController : UIViewController

@property(assign, nonatomic) id<LoginDelegate> delegate;

@end
