//
//  StudyCollectionViewCell.m
//  MedicalTech
//
//  Created by Jason on 7/13/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "StudyCollectionViewCell.h"

@implementation StudyCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH/2.0 - 9.0, 128.0*SCREEN_WIDTH/414.0)];
        [self addSubview:imageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 131.0*SCREEN_WIDTH/414.0, SCREEN_WIDTH/2.0 - 9.0, 20.0*SCREEN_WIDTH/414.0)];
        titleLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightThin];
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)setText:(NSDictionary *)data {
    NSString *imgUrl = [data objectForKey:@"img"];
    NSString *exam_name = [data objectForKey:@"exam_name"];
    
    [imageView setImageWithURL:[NSURL URLWithString:imgUrl]];
    titleLabel.text = exam_name;
}

@end
