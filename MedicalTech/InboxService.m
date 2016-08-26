//
//  InboxService.m
//  MedicalTech
//
//  Created by Jason on 8/25/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "InboxService.h"

@implementation InboxService

- (void)getMyMessage {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:MESSAGELIST parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            [self.delegate returnMyMessage:[dictionary objectForKey:@"data"]];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINTIMEOUT" object:nil userInfo:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
