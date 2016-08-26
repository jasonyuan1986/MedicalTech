//
//  LoginService.h
//  MedicalTech
//
//  Created by Jason on 8/19/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginServiceDelegate <NSObject>

- (void)loginSuccess;

@end

@interface LoginService : NSObject

- (void)signin:(NSString *)mobile password:(NSString *)password;

@end
