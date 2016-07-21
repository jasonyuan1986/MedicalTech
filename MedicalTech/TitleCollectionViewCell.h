//
//  TitleCollectionViewCell.h
//  MedicalTech
//
//  Created by Jason on 7/19/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionViewCell : UICollectionViewCell
{
    UILabel *titleLabel;
}

- (void)setText:(NSString *)text;

@end
