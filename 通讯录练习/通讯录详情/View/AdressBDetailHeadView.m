//
//  AdressBDetailHeadView.m
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/7.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import "AdressBDetailHeadView.h"

@implementation AdressBDetailHeadView
-(void)awakeFromNib{
    [super awakeFromNib];
    // 圆角
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 50.0;
}
@end
