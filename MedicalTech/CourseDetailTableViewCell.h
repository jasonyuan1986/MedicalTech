//
//  CourseDetailTableViewCell.h
//  MedicalTech
//
//  Created by Jason on 8/22/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseDetailTableViewCell : UITableViewCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
    UILabel *personLabel;
    UILabel *scoreLabel;
}

- (void)setText:(NSDictionary *)data;

@end
