//
//  RelatedCollectionViewCell.h
//  MedicalTech
//
//  Created by Jason on 8/16/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelatedCollectionViewCell : UICollectionViewCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
}

- (void)setText:(NSDictionary *)data;

@end
