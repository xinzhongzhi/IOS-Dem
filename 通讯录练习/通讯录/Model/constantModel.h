//
//  constantModel.h
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/5.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface constantModel : NSObject
@property(copy,nonatomic) NSString * familName;/*电话备注名称*/
@property(copy,nonatomic) NSString * phoneNumber;/*电话号码*/
- (id)initWithDict:(NSDictionary *)dict;

@end
