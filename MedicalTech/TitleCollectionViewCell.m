//
//  TitleCollectionViewCell.m
//  MedicalTech
//
//  Created by Jason on 7/19/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(00.0, 0.0, 80.0, 24.0)];
        titleLabel.textColor = [UIColor colorWithRed:30.0/255.0 green:198.0/255.0 blue:180.0/255.0 alpha:1.0];
        titleLabel.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightThin];
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)setText:(NSString *)text {
    titleLabel.text = text;
}

@end
