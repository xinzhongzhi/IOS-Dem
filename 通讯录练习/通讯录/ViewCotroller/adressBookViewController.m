//
//  adressBookViewController.m
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/6.
//  Copyright © 2017年 辛忠志. All rights reserved.
//
#define HRXIB(Class) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Class class]) owner:nil options:nil] firstObject];
#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "adressBookViewController.h"
#import "AdressBDetailViewController.h"
#pragma mark ----------------------- 系统类型 -----------------------
#import <ContactsUI/ContactsUI.h>
#pragma mark ----------------------- View类型 -----------------------
#import "constantsTableViewCell.h"
#pragma mark ----------------------- Model类型 -----------------------
#import "JSONModel.h"
#import "BMChineseSort.h"
@interface adressBookViewController ()<CNContactPickerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property (strong,nonatomic)NSMutableDictionary * contactsDic;/*里层通讯录的字典 存储每条数据*/
@property (strong,nonatomic)NSMutableArray * contactsSource;/*外层数据源通讯录*/
@property (strong,nonatomic)NSMutableArray * contactsSourceList;/*外层数据源通讯录*/

//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property (strong,nonatomic)NSMutableArray * searchResultArray;/*搜索完之后的数据(数组类型)*/
@property (strong,nonatomic)NSMutableArray * searchModelResultArray;/*搜索完之后的数据(model类型)*/
@property (strong,nonatomic)NSMutableArray * contactsModelSourceList;
/**我们的UISearchDisplayController*/
@property (nonatomic, strong) UISearchDisplayController *displayer;
@end

@implementation adressBookViewController
#pragma mark - ---------- Lazy Loading（懒加载） ----------
-(NSMutableArray *)contactsSource{
    if (!_contactsSource) {
        _contactsSource = [NSMutableArray array];
    }
    return _contactsSource;
}
-(NSMutableDictionary *)contactsDic{
    if (!_contactsDic) {
        _contactsDic = [NSMutableDictionary dictionary];
    }
    return _contactsDic;
}
-(NSMutableArray *)contactsSourceList{
    if (!_contactsSourceList) {
        _contactsSourceList = [NSMutableArray array];
    }
    return _contactsSourceList;
}
-(NSMutableArray *)searchResultArray{
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}
-(NSMutableArray *)searchModelResultArray{
    if (!_searchModelResultArray) {
        _searchModelResultArray = [NSMutableArray array];
    }
    return _searchModelResultArray;
}
#pragma mark - ----------   Lifecycle（生命周期） ----------
-(void)viewWillAppear:(BOOL)animated
{
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainSearchBar.delegate = self;
    /*初始化通讯录UI*/
    [self contactsUI];
    /*初始化布局*/
    [self configUI];
}
- (void)contactsUI{
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusAuthorized) {
        NSLog(@"没有授权...");
    }
    
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        self.contactsDic = [NSMutableDictionary dictionary];
        NSLog(@"-------------------------------------------------------");
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
        [self.contactsDic setObject:familyName forKey:@"familName"];
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phoneNumbers) {
            NSString *label = labelValue.label;
            CNPhoneNumber *phoneNumber = labelValue.value;
            [self.contactsDic setObject:phoneNumber.stringValue forKey:@"phoneNumber"];
            NSLog(@"label=%@, phone=%@", label, phoneNumber.stringValue);
        }
        
        NSLog(@"%@",self.contactsDic);
        [self.contactsSource addObject:self.contactsDic];
        //        *stop = YES;  // 停止循环，相当于break；
    }];
    NSLog(@"%ld",self.contactsSource.count);
    NSLog(@"%@",self.contactsSource);
    //根据Person对象的 name 属性 按中文 对 Person数组 排序
    self.indexArray = [BMChineseSort IndexWithArray:self.contactsSource Key:@"familName"];
    NSLog(@"%@",self.indexArray);
    
    
    for (int i = 0; i < self.contactsSource.count; i++) {
        
        constantModel *model = [[constantModel alloc] initWithDict:self.contactsSource[i]];
        [self.contactsSourceList addObject:model];
    }
    self.letterResultArr = [BMChineseSort sortObjectArray:self.contactsSourceList Key:@"familName"];
    
    
    NSLog(@"%@",self.letterResultArr);
    [self.mainTableView reloadData];
}


#pragma mark - ---------- Private Methods（私有方法） ----------

#pragma mark initliaze data(初始化数据)
#pragma mark config control（布局控件）
-(void)configUI{    
    self.displayer = [[UISearchDisplayController alloc] initWithSearchBar:self.mainSearchBar contentsController:self];
    /**searchBar的delegate看需求进行配置*/
    self.mainSearchBar.delegate = self;
    
    /**以下都比较重要，建议都设置好代理*/
    self.displayer.searchResultsDataSource = self;
    self.displayer.searchResultsDelegate = self;
    self.displayer.delegate = self;
}
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
#pragma mark ----------------UITableViewDataSource---------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.displayer.searchResultsTableView) {
        return self.searchModelResultArray.count;
    }else{
        return [self.letterResultArr[section] count];
    }
}
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.displayer.searchResultsTableView) {
        
    }else{
        return [self.indexArray objectAtIndex:section];
    }
    return nil;
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.displayer.searchResultsTableView) {
        return 1;
    }else{
        return [self.indexArray count];
    }
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*去掉系统分割线**/
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    constantsTableViewCell * cell = HRXIB(constantsTableViewCell);
    
    /*如果是searchTB类型的*/
    if (tableView == self.displayer.searchResultsTableView) {
        /*赋值必须是model类型的list*/
        @try {
            constantModel * model = self.searchModelResultArray[indexPath.row];
            [cell addInfoModel:model];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    /*传统类型的*/
    else{
        self.contactsModelSourceList = [NSMutableArray array];
        @try {
            NSLog(@"%@",self.letterResultArr);
            self.contactsModelSourceList = self.letterResultArr [indexPath.section];
            NSLog(@"%@",self.contactsModelSourceList);
            //调用方法，给单元格赋值
            constantModel * model = self.contactsModelSourceList[indexPath.row];
            
            [cell addInfoModel:model];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    /* 去掉cell点击阴影**/
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    /*设置文字和图片*/
    return cell;
}
#pragma mark ----------------UITableViewDelegate---------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*因为两者的数据是不一样的所以分开写*/
    
    if (tableView == self.displayer.searchResultsTableView) {
        constantModel * model = self.searchModelResultArray[indexPath.row];
        AdressBDetailViewController * vc = [[AdressBDetailViewController alloc]init];
        vc.familName = model.familName ;
        vc.phoneNumber = model.phoneNumber;
        NSLog(@"%@",model.familName);
        NSLog(@"%@",model.phoneNumber);
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        self.contactsModelSourceList = self.letterResultArr [indexPath.section];
        NSLog(@"%@",self.contactsModelSourceList);
        //调用方法，给单元格赋值
        constantModel * model = self.contactsModelSourceList[indexPath.row];
        AdressBDetailViewController * vc = [[AdressBDetailViewController alloc]init];
        vc.familName = model.familName ;
        vc.phoneNumber = model.phoneNumber;
        NSLog(@"%@",model.familName);
        NSLog(@"%@",model.phoneNumber);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"begin");
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"end");
    return  YES;
}
#pragma mark ----------------UISearchDisplayDelegate---------------------
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"%@",self.contactsSource);
    self.searchModelResultArray = [NSMutableArray array];
//    /**通过谓词修饰的方式来查找包含我们搜索关键字的数据*/
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.familName CONTAINS[cd] %@",searchString];
    NSLog(@"%@",predicate);
    self.searchResultArray = [[self.contactsSource filteredArrayUsingPredicate:predicate]mutableCopy];
    NSLog(@"%@",self.searchResultArray);
    
    for (int i = 0; i < self.searchResultArray.count; i++) {
        
        constantModel *model = [[constantModel alloc] initWithDict:self.searchResultArray[i]];
        [self.searchModelResultArray addObject:model];
    }
    NSLog(@"%@",self.searchModelResultArray);
    return  YES;
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
