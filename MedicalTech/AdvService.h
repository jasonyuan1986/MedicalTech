//
//  AdvService.h
//  MedicalTech
//
//  Created by Jason on 8/15/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdvServiceDelegate <NSObject>

- (void)returnAdvList:(NSArray *)dataArray;

@end

@interface AdvService : NSObject

@property (nonatomic, assign) id<AdvServiceDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)getAdvList:(NSString *)advId;

@end
