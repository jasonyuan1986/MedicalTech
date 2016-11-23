//
//  StudyPlanTableViewCell.h
//  MedicalTech
//
//  Created by Jason on 9/6/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyPlanTableViewCell : UITableViewCell
{
    UILabel *titleLabel;
    UILabel *totalTimeFieldLabel;
    UILabel *totalTimeLabel;
    UILabel *studyDateFieldLabel;
    UILabel *studyDateLabel;
}

- (void)setText:(NSDictionary *)data;

@end
