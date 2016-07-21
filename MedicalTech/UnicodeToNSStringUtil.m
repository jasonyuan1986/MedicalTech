//
//  UnicodeToNSStringUtil.m
//  MedicalTech
//
//  Created by Jason on 7/11/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "UnicodeToNSStringUtil.h"

@implementation UnicodeToNSStringUtil

+ (NSString *)replaceUnicode:(NSString *)unicodeString {
    NSString *tempStr1 = [unicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
//                                                           mutabilityOption:NSPropertyListImmutable
//                                                                     format:NULL
//                                                           errorDescription:NULL];
    
    NSString *returnString = [NSPropertyListSerialization propertyListWithData:tempData
                                                                       options:NSPropertyListImmutable
                                                                        format:nil
                                                                         error:nil];
    
    return [returnString stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

@end
