//
//  CourseMovieListService.h
//  MedicalTech
//
//  Created by Jason on 8/15/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CourseMovieListServiceDelegate <NSObject>

- (void)returnCourseMovieList:(NSArray *)dataArray Tag:(int)tag;
- (void)relogin;

@end

@interface CourseMovieListService : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic, assign) id<CourseMovieListServiceDelegate> delegate;

- (void)getCourseMovieList:(NSString *)subjectId
                 orderType:(NSString *)orderType
                 recommend:(NSString *)recommend
                    pageNo:(int)pageNo
                  pageSize:(int)pageSize;

@end
