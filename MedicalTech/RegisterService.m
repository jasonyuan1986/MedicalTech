//
//  RegisterService.m
//  MedicalTech
//
//  Created by Jason on 8/3/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "RegisterService.h"

@implementation RegisterService

@synthesize delegate;

- (void)mobileRegister:(NSString *)mobileNo validCode:(NSString *)validCode {
    NSString *requestUrl = [NSString stringWithFormat:@"%@mobileNo=%@&validCode=%@", REGISTER, mobileNo, validCode];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSString *token = [dictionary objectForKey:@"data"];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            [self.delegate registerTokenCallBack:token];
        } else {
            [MBProgressUtil MBShowMessage:[dictionary objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)setNewPassword:(NSString *)newPassword {
    NSString *requestUrl = [NSString stringWithFormat:@"%@newPwd=%@", SETNEWPASSWORD, newPassword];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"registerToken"];
    [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            [self.delegate setNewPasswordSuccess];
        } else {
            [MBProgressUtil MBShowMessage:[dictionary objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)bindNo:(NSString *)number {
    NSString *requestUrl = [NSString stringWithFormat:@"%@no=%@", BINDNO, number];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"registerToken"];
    [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            [MBProgressUtil MBShowMessage:[dictionary objectForKey:@"msg"]];
            [self.delegate bindNoSuccess];
        } else {
            [MBProgressUtil MBShowMessage:[dictionary objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
