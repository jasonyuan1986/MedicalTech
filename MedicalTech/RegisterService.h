//
//  RegisterService.h
//  MedicalTech
//
//  Created by Jason on 8/3/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegisterServiceDelegate <NSObject>

@optional

- (void)registerTokenCallBack:(NSString *)registerToken;

- (void)setNewPasswordSuccess;

- (void)bindNoSuccess;

@end

@interface RegisterService : NSObject

@property (nonatomic, assign) id<RegisterServiceDelegate> delegate;

- (void)mobileRegister:(NSString *)mobileNo validCode:(NSString *)validCode;

- (void)setNewPassword:(NSString *)newPassword;

- (void)bindNo:(NSString *)number;

@end
