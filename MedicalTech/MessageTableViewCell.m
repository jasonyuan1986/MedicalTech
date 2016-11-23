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
            make.left.equalTo(self).offset(11);
            make.top.equalTo(self).offset(11);
            make.size.mas_equalTo(CGSizeMake(48, 48));
        }];
        
        dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self addSubview:dateLabel];
        
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(8);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightThin];
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(dateLabel.mas_left).offset(-5);
            make.left.equalTo(imageView.mas_right).offset(5);
            make.top.equalTo(self).offset(8);
            make.height.mas_equalTo(20);
        }];
        
        contentLabel = [[UILabel alloc] init];
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contentLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightThin];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(50);
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
    BOOL isRead = [data objectForKey:@"isRead"];
    NSString *date = [data objectForKey:@"createDt"];
    NSString *title = [data objectForKey:@"title"];
    NSString *remark = [data objectForKey:@"remark"];
    
    if (isRead) {
        titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    } else {
        titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
    }
    
    titleLabel.text = title;
    dateLabel.text = [date substringWithRange:NSMakeRange(0, 10)];
    contentLabel.text = remark;
}

@end
