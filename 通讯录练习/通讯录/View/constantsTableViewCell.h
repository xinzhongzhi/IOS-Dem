//
//  constantsTableViewCell.h
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/5.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constantModel.h"
@interface constantsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelabel;/*通讯录电话本的昵称*/
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;/*电话号码*/
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;/*头像*/
- (void)addInfoModel:(constantModel *)infoModel;
@end
