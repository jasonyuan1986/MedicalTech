//
//  MBProgressUtil.h
//  MedicalTech
//
//  Created by Jason on 8/5/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBProgressUtil : NSObject

+ (void)showHUD;

+ (void)hideHUD;

+ (void)MBShowMessage:(NSString *)message;

@end
