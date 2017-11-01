//
//  AdressBDetailViewController.h
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/7.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdressBDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;/*主TB*/
@property (copy,nonatomic)NSString * familName;/*昵称*/
@property (copy,nonatomic)NSString * phoneNumber;/*电话*/
@end
