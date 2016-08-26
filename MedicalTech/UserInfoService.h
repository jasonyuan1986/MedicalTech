//
//  UserInfoService.h
//  MedicalTech
//
//  Created by Jason on 8/19/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserInfoServiceDelegate <NSObject>

- (void)returnUserInfo:(NSDictionary *)data;
- (void)relogin;

@end

@interface UserInfoService : NSObject

@property (nonatomic, assign) id<UserInfoServiceDelegate> delegate;

- (void)getUserInfo;

@end
