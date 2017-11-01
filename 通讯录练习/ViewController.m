//
//  ViewController.m
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/6.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import "ViewController.h"
#import "adressBookViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - ---------- Lazy Loading（懒加载） ----------

#pragma mark - ----------   Lifecycle（生命周期） ----------

#pragma mark - ---------- Private Methods（私有方法） ----------

#pragma mark initliaze data(初始化数据)

#pragma mark config control（布局控件）

#pragma mark networkRequest (网络请求)

#pragma mark actions （点击事件）

#pragma mark IBActions （点击事件xib）
/*钉钉好友*/
- (IBAction)dingdingFriend:(UIButton *)sender {
    
}
/*手机通讯录*/
- (IBAction)phoneAdress:(UIButton *)sender {
    adressBookViewController * vc = [[adressBookViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*我的主页*/
- (IBAction)myFlock:(UIButton *)sender {
    
}
/*企业主业*/
- (IBAction)companyFirstP:(UIButton *)sender {
    
}

#pragma mark - ---------- Public Methods（公有方法） ----------

#pragma mark self declare （本类声明）

#pragma mark override super （重写父类）

#pragma mark setter （重写set方法）

#pragma mark - ---------- Protocol Methods（代理方法） ----------
#pragma mark ----------------UITableViewDataSource---------------------
#pragma mark ----------------UITableViewDelegate---------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
