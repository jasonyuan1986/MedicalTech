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
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:MYCOURSE parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            NSArray *array = [dictionary objectForKey:@"data"];
            [self.delegate returnMyCourse:array];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINTIMEOUT" object:nil userInfo:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)getCourseDetail:(NSString *)listId pageNo:(int)pageNo pageSize:(int)pageSize {
    NSString *request = [NSString stringWithFormat:@"%@_%@_%d_%d", COURSEDETAIL, listId, pageNo, pageSize];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:request parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            NSArray *array = [dictionary objectForKey:@"data"];
            [self.delegate returnCourseDetail:array];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINTIMEOUT" object:nil userInfo:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

@end
