//
//  CourseDetailTableViewCell.m
//  MedicalTech
//
//  Created by Jason on 8/22/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "CourseDetailTableViewCell.h"

@implementation CourseDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 5.0, 80, 60)];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(5);
            make.size.mas_equalTo(CGSizeMake(90, 70));
        }];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-20);
            make.height.mas_equalTo(40);
        }];
        
        personLabel = [[UILabel alloc] init];
        personLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        personLabel.textColor = [UIColor colorWithRed:0.693 green:0.483 blue:0.461 alpha:1.000];
        [self addSubview:personLabel];
        
        [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
            make.bottom.equalTo(self).offset(-5);
            make.size.mas_equalTo(CGSizeMake(100, 26));
        }];
        
        scoreLabel = [[UILabel alloc] init];
        scoreLabel.textAlignment = NSTextAlignmentRight;
        scoreLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        scoreLabel.textColor = [UIColor colorWithRed:0.693 green:0.483 blue:0.461 alpha:1.000];
        [self addSubview:scoreLabel];
        
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.bottom.equalTo(self).offset(-5);
            make.size.mas_equalTo(CGSizeMake(100, 26));
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setText:(NSDictionary *)data {
    NSString *imgUrl = [data objectForKey:@"img"];
    NSString *title = [data objectForKey:@"exam_name"];
    NSString *expertsName = [data objectForKey:@"experts_name"];
    NSNumber *point = [data objectForKey:@"point"];
    
    if (![imgUrl isEqual:[NSNull null]]) {
        [imageView setImageWithURL:[NSURL URLWithString:imgUrl]];
    }
    
    if (![title isEqual:[NSNull null]]) {
        titleLabel.text = title;
    }
    
    if (![expertsName isEqual:[NSNull null]]) {
        personLabel.text = [NSString stringWithFormat:@"专家：%@", expertsName];
    }
    
    if (![point isEqual:[NSNull null]]) {
        scoreLabel.text = [NSString stringWithFormat:@"学分：%@", point];
    }
}

@end
