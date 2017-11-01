//
//  constantsTableViewCell.m
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/5.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import "constantsTableViewCell.h"
#import "constantModel.h"
@implementation constantsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 圆角
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 55.0/2;
}
- (void)addInfoModel:(constantModel *)infoModel
{
    self.namelabel.text = infoModel.familName;
    self.phoneLabel.text = infoModel.phoneNumber;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
