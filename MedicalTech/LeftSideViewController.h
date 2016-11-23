//
//  LeftSideViewController.h
//  MedicalTech
//
//  Created by Jason on 7/26/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftSideViewDelegate <NSObject>

- (void)goToInbox;
- (void)goToSettings;
- (void)goToMyCourse;
- (void)goToStudyPlan;
- (void)goToHelp;

@end

@interface LeftSideViewController : UIViewController

@property (nonatomic, assign) id<LeftSideViewDelegate> delegate;

@end
