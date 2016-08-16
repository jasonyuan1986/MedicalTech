//
//  SMSService.h
//  MedicalTech
//
//  Created by Jason on 8/3/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMSService : NSObject

+ (void)getSms:(NSString *)mobiles smsType:(NSString *)sendType;

+ (void)validSms:(NSString *)mobiles smsType:(NSString *)smsType validCode:(NSString *)validCode;

@end
