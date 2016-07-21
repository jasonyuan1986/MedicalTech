//
//  PlatformTableViewCell.h
//  MedicalTech
//
//  Created by Jason on 7/10/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlatformTableViewCell : UITableViewCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIView *splitView;
}

- (void)setText:(NSDictionary *)data;

@end
