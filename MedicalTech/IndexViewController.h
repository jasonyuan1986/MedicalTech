//
//  IndexViewController.h
//  MedicalTech
//
//  Created by Jason on 7/1/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexViewDelegate <NSObject>

- (void)relogin;

@end

@interface IndexViewController : UIViewController

@property (nonatomic, assign) id<IndexViewDelegate> delegate;

@end
