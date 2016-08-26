//
//  MessageTableViewCell.m
//  MedicalTech
//
//  Created by Jason on 8/25/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gonggao"]];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(3);
            make.top.equalTo(self).offset(3);
            make.size.mas_equalTo(CGSizeMake(64, 64));
        }];
        
        dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self addSubview:dateLabel];
        
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(dateLabel.mas_left).offset(-5);
            make.left.equalTo(imageView.mas_right).offset(5);
            make.top.equalTo(self).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, SCREEN_WIDTH * 201.0/414.0 + 47.0, SCREEN_WIDTH - 32.0, 48.0)];
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contentLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightThin];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
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
    
}

@end
