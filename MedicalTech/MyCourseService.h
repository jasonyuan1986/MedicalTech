//
//  MyCourseService.h
//  MedicalTech
//
//  Created by Jason on 8/16/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyCourseServiceDelegate <NSObject>

@optional
- (void)returnMyCourse:(NSArray *)dataArray;

- (void)returnCourseDetail:(NSArray *)dataArray;

@end

@interface MyCourseService : NSObject

@property (nonatomic, assign) id<MyCourseServiceDelegate> delegate;

- (void)getMyCourse;

- (void)getCourseDetail:(NSString *)listId pageNo:(int)pageNo pageSize:(int)pageSize;

@end
