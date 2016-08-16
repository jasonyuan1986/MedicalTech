//
//  SMSService.m
//  MedicalTech
//
//  Created by Jason on 8/3/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "SMSService.h"

@implementation SMSService

+ (void)getSms:(NSString *)mobiles smsType:(NSString *)smsType {
    NSString *requestUrl = [NSString stringWithFormat:@"%@mobile=%@&smsType=%@", GETSMS, mobiles, smsType];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@", [dictionary objectForKey:@"msg"]);
        [MBProgressUtil MBShowMessage:@"验证码已发送"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

+ (void)validSms:(NSString *)mobiles smsType:(NSString *)smsType validCode:(NSString *)validCode {
    NSString *requestUrl = [NSString stringWithFormat:@"%@mobiles=%@&smsType=%@&validCode=%@", GETSMS, mobiles, smsType, validCode];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
