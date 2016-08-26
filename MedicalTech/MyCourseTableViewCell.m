//
//  MyCourseTableViewCell.m
//  MedicalTech
//
//  Created by Jason on 8/16/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "MyCourseTableViewCell.h"

@implementation MyCourseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 5.0, 80, 60)];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 60));
        }];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
            make.top.equalTo(self).offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 26));
        }];
        
        trainTimeLabel = [[UILabel alloc] init];
        trainTimeLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self addSubview:trainTimeLabel];
        
        [trainTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
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
    NSString *title = [data objectForKey:@"names"];
    NSString *trainTime = [data objectForKey:@"trainbaseId"];
    
    if (![imgUrl isEqual:[NSNull null]]) {
        NSString *url = [NSString stringWithFormat:@"%@%@%@", HOST, @"hn_edu/", imgUrl];
        [imageView setImageWithURL:[NSURL URLWithString:url]];
    }
    
    if (![title isEqual:[NSNull null]]) {
        titleLabel.text = title;
    }
    
    if (![trainTime isEqual:[NSNull null]]) {
        trainTimeLabel.text = [NSString stringWithFormat:@"需要学时：%@", trainTime];
    }
}

@end
