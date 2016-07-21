//
//  StudyCollectionViewCell.h
//  MedicalTech
//
//  Created by Jason on 7/13/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyCollectionViewCell : UICollectionViewCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
}

- (void)setText:(NSDictionary *)data;

@end
