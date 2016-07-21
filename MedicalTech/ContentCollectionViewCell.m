//
//  ContentCollectionViewCell.m
//  MedicalTech
//
//  Created by Jason on 7/20/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "ContentCollectionViewCell.h"

@implementation ContentCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH/3.0 - 10.0, 80.0)];
        [self addSubview:imageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 80.0, SCREEN_WIDTH/3.0 - 10.0, 20.0)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightThin];
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)setText:(NSDictionary *)data {
    [imageView setImageWithURL:[NSURL URLWithString:[data objectForKey:@"img"]]];
    
    titleLabel.text = [data objectForKey:@"exam_name"];
}

@end
