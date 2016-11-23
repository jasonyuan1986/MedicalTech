//
//  DictInfoService.h
//  MedicalTech
//
//  Created by Jason on 9/2/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DictInfoServiceDelegate <NSObject>

- (void)returnDictInfo:(NSArray *)dataArray;

@end

@interface DictInfoService : NSObject

@property (nonatomic, assign) id<DictInfoServiceDelegate> delegate;

- (void)getDictInfo;

@end
