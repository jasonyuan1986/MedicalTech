//
//  CourseMovieListService.m
//  MedicalTech
//
//  Created by Jason on 8/15/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "CourseMovieListService.h"

@implementation CourseMovieListService

@synthesize tag;
@synthesize delegate;

/**
 *  推荐视频列表接口
 *
 *  @param subjectId 分类ID
 *  @param orderType 排序：1 最新更新；2 点击排行
 *  @param recommend 1 推荐
 *  @param pageNo    页码
 *  @param pageSize  每页记录条数
 */
- (void)getCourseMovieList:(nullable NSString *)subjectId
                 orderType:(nullable NSString *)orderType
                 recommend:(nullable NSString *)recommend
                    pageNo:(int)pageNo
                  pageSize:(int)pageSize
{
    NSString *request = [NSString stringWithFormat:@"%@_%@_%@_%@_%d_%d", COURSEMOVIELIST, subjectId, orderType, recommend, pageNo, pageSize];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:request parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 5) {
            [self.delegate relogin];
        } else if ([ret intValue] == 9) {
            [self.delegate relogin];
        } else {
            [self.delegate returnCourseMovieList:[dictionary objectForKey:@"data"] Tag:self.tag];
        }
//        self.studyArray = [dictionary objectForKey:@"data"];
        
//        NSLog(@"%@", self.studyArray);
//        [self.studyCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
