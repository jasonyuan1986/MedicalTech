//
//  PlatformTableViewCell.m
//  MedicalTech
//
//  Created by Jason on 7/10/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "PlatformTableViewCell.h"
#import "UnicodeToNSStringUtil.h"

@implementation PlatformTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_WIDTH * 201.0/414.0)];
        [self addSubview:imageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, SCREEN_WIDTH * 201.0/414.0, SCREEN_WIDTH - 32.0, 47.0)];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, SCREEN_WIDTH * 201.0/414.0 + 47.0, SCREEN_WIDTH - 32.0, 48.0)];
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contentLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightThin];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        
        splitView = [[UIView alloc] initWithFrame:CGRectMake(0.0, contentLabel.frame.origin.y + contentLabel.frame.size.height, SCREEN_WIDTH, 18.0 * SCREEN_WIDTH/414.0)];
        splitView.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:232.0/255.0 blue:234.0/255.0 alpha:1.0];
        [self addSubview:splitView];
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
    NSString *exam_name = [data objectForKey:@"exam_name"];
    NSString *content = [data objectForKey:@"content"];
    
    if ([content isEqual:[NSNull null]]) {
        content = @"";
    }
    
    [imageView setImageWithURL:[NSURL URLWithString:imgUrl]];
    titleLabel.text = exam_name;
    contentLabel.text = content;
}

@end
