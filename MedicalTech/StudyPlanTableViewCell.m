//
//  StudyPlanTableViewCell.m
//  MedicalTech
//
//  Created by Jason on 9/6/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "StudyPlanTableViewCell.h"

@implementation StudyPlanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(5);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];
        
        totalTimeFieldLabel = [[UILabel alloc] init];
        totalTimeFieldLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
        totalTimeFieldLabel.text = @"总学时";
        [self addSubview:totalTimeFieldLabel];
        
        [totalTimeFieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        totalTimeLabel = [[UILabel alloc] init];
        totalTimeLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self addSubview:totalTimeLabel];
        
        [totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(totalTimeFieldLabel.mas_right).offset(5);
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        studyDateLabel = [[UILabel alloc] init];
        studyDateLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self addSubview:studyDateLabel];
        
        [studyDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        studyDateFieldLabel = [[UILabel alloc] init];
        studyDateFieldLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
        studyDateFieldLabel.text = @"学习日期";
        [self addSubview:studyDateFieldLabel];
        
        [studyDateFieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(studyDateLabel.mas_left).offset(-5);
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 20));
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
    NSNumber *total_time = [data objectForKey:@"total_time"];
    NSString *studyDate = [data objectForKey:@"study_time"];
    NSString *examName = [data objectForKey:@"examName"];
    
    if (![examName isEqual:[NSNull null]]) {
        titleLabel.text = examName;
    }
    
    if (![total_time isEqual:[NSNull null]]) {
        totalTimeLabel.text = [NSString stringWithFormat:@"%@", total_time];
    }
    
    if (![studyDate isEqual:[NSNull null]]) {
        studyDateLabel.text = [studyDate substringToIndex:9];
    }
}

@end
