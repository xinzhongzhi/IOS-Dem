//
//  AdressBDetailHeadView.h
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/7.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdressBDetailHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;/*头像*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;/*姓名*/
@property (weak, nonatomic) IBOutlet UIView *typeView;/*需要判断机型来展示View的宽度 因为5s是顶格的 而6P不是*/

@end
