//
//  MyCourseService.m
//  MedicalTech
//
//  Created by Jason on 8/16/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "MyCourseService.h"



@implementation MyCourseService

@synthesize delegate;

- (void)getMyCourse {
    [MBProgressUtil showHUD];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:MYCOURSE parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressUtil hideHUD];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            NSArray *array = [dictionary objectForKey:@"data"];
            [self.delegate returnMyCourse:array];
        } else if ([ret intValue] == 5) {
            [MBProgressUtil MBShowMessage:@"没有登录，请先登录"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINTIMEOUT" object:nil userInfo:nil];
        } else if ([ret intValue] == 9) {
            [MBProgressUtil MBShowMessage:@"登录超时，请重新登录"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINTIMEOUT" object:nil userInfo:nil];
        } else {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressUtil hideHUD];
    }];
}

- (void)getCourseDetail:(NSString *)listId pageNo:(int)pageNo pageSize:(int)pageSize {
    [MBProgressUtil showHUD];
    NSString *request = [NSString stringWithFormat:@"%@_%@_%d_%d", COURSEDETAIL, listId, pageNo, pageSize];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:request parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressUtil hideHUD];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            NSArray *array = [dictionary objectForKey:@"data"];
            [self.delegate returnCourseDetail:array];
        } else if ([ret intValue] == 5){
            [MBProgressUtil MBShowMessage:@"没有登录，请先登录"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINTIMEOUT" object:nil userInfo:nil];
        } else if ([ret intValue] == 9) {
            [MBProgressUtil MBShowMessage:@"登录超时，请重新登录"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINTIMEOUT" object:nil userInfo:nil];
        } else {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressUtil hideHUD];
    }];
}

@end
