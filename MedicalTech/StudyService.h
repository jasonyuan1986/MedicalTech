//
//  StudyService.h
//  MedicalTech
//
//  Created by Jason on 9/6/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StudyServiceDelegate <NSObject>

- (void)returnStudyPlan:(NSArray *)dataArray;

@end

@interface StudyService : NSObject

@property (nonatomic, assign) id<StudyServiceDelegate> delegate;

- (void)getStudyPlan;

@end
