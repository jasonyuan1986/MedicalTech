//
//  MBProgressUtil.m
//  MedicalTech
//
//  Created by Jason on 8/5/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "MBProgressUtil.h"

@implementation MBProgressUtil

+ (void)MBShowMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    });
}

@end
