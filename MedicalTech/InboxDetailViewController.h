//
//  InboxDetailViewController.h
//  MedicalTech
//
//  Created by Jason on 12/09/2016.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *data;

- (void)setData:(NSDictionary *)data;

@end
