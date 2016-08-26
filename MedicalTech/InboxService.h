//
//  InboxService.h
//  MedicalTech
//
//  Created by Jason on 8/25/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InboxServiceDelegate <NSObject>

- (void)returnMyMessage:(NSArray *)dataArray;

@end

@interface InboxService : NSObject

@property (nonatomic, assign) id<InboxServiceDelegate> delegate;

- (void)getMyMessage;

@end
