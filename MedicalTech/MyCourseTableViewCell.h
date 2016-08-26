//
//  MyCourseTableViewCell.h
//  MedicalTech
//
//  Created by Jason on 8/16/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCourseTableViewCell : UITableViewCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
    UILabel *trainTimeLabel;
}

- (void)setText:(NSDictionary *)data;

@end
