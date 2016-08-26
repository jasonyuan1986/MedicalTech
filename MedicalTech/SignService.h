//
//  SignService.h
//  MedicalTech
//
//  Created by Jason on 8/18/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SignServiceDelegate <NSObject>

- (void)logoutSuccess;

@end

@interface SignService : NSObject

@property (assign, nonatomic) id<SignServiceDelegate> delegate;

- (void)signout;

@end
