//
//  DictInfoService.m
//  MedicalTech
//
//  Created by Jason on 9/2/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "DictInfoService.h"

@implementation DictInfoService

- (void)getDictInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:DICTINFOLIST parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressUtil hideHUD];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            [self.delegate returnDictInfo:[dictionary objectForKey:@"data"]];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINTIMEOUT" object:nil userInfo:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressUtil hideHUD];
    }];
}

@end
