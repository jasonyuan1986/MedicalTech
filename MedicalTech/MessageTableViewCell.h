//
//  MessageTableViewCell.h
//  MedicalTech
//
//  Created by Jason on 8/25/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
    UILabel *dateLabel;
    UILabel *contentLabel;
}

- (void)setText:(NSDictionary *)data;

@end
