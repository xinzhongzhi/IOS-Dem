//
//  AdressBDetailViewController.m
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/7.
//  Copyright © 2017年 辛忠志. All rights reserved.
//
#define HRXIB(Class) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Class class]) owner:nil options:nil] firstObject];
#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#import "AdressBDetailViewController.h"
#pragma mark ----------------------- View类型 -----------------------
#import "AdressBDetailHeadView.h"
@interface AdressBDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;/*标题 用来实现渐变效果*/
@property (strong,nonatomic)AdressBDetailHeadView * headView;/*头部视图*/

@end

@implementation AdressBDetailViewController
#pragma mark - ---------- Lazy Loading（懒加载） ----------
- (AdressBDetailHeadView *)headView{
    if (!_headView) {
        _headView = HRXIB(AdressBDetailHeadView);
        _headView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 400);
    }
    return _headView;
}
#pragma mark - ----------   Lifecycle（生命周期） ----------
- (void)viewDidLoad {
    [super viewDidLoad];
    /*布局*/
    [self configUI];
    /*初始化数据*/
    [self configData];
}


#pragma mark - ---------- Private Methods（私有方法） ----------

#pragma mark initliaze data(初始化数据)
-(void)configUI{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 400)];
    [self.view addSubview:view];
    [view addSubview:self.headView];
    self.mainTableView.tableHeaderView = view;
    self.mainTableView.delegate = self;
}
-(void)configData{
    /*对详情页面的昵称和图片进行展示*/
    if ([self.familName isEqualToString:@""]) {
        self.headView.nameLabel.text = @"姓名";
        
    }else{
        self.headView.nameLabel.text = self.familName;
    }
}
#pragma mark config control（布局控件）

#pragma mark networkRequest (网络请求)

#pragma mark actions （点击事件）

#pragma mark IBActions （点击事件xib）

- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - ---------- Public Methods（公有方法） ----------

#pragma mark self declare （本类声明）

#pragma mark override super （重写父类）

#pragma mark setter （重写set方法）

#pragma mark - ---------- Protocol Methods（代理方法） ----------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /*判断TB向上滑动还是向下滑动*/
    if (scrollView.contentOffset.y>70) {
        NSLog(@"上");
        self.titleLabel.hidden = NO;
        self.titleLabel.text = self.familName;
        
        [UIView animateWithDuration:1 animations:^{
        }completion:^(BOOL finished) {
            if (finished){
                self.headView.headImageView.alpha = 0;
                self.headView.nameLabel.alpha = 0;
            }
        }];
    }else{
        NSLog(@"下");
        [UIView animateWithDuration:1 animations:^{
        }completion:^(BOOL finished) {
            if (finished){
                self.headView.headImageView.alpha = 1;
                self.headView.nameLabel.alpha = 1;
            }
        }];
        self.titleLabel.hidden = YES;
    }
}
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
