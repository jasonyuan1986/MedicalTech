//
//  UserInfoService.m
//  MedicalTech
//
//  Created by Jason on 8/19/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "UserInfoService.h"

@implementation UserInfoService

@synthesize delegate;

- (void)getUserInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:USERINFO parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            [self.delegate returnUserInfo:[dictionary objectForKey:@"data"]];
        } else {
            [self.delegate relogin];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

@end
