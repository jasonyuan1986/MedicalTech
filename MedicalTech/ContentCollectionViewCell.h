//
//  ContentCollectionViewCell.h
//  MedicalTech
//
//  Created by Jason on 7/20/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCollectionViewCell : UICollectionViewCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
}

- (void)setText:(NSDictionary *)data;

@end
