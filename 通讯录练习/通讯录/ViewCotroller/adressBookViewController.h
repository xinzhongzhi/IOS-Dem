//
//  adressBookViewController.h
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/6.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adressBookViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mainSearchBar;

@end
