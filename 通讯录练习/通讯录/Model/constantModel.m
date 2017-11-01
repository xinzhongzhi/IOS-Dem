//
//  constantModel.m
//  通讯录练习
//
//  Created by 辛忠志 on 2017/9/5.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import "constantModel.h"


@implementation constantModel
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.familName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"familName"]];
        
        self.phoneNumber = [NSString stringWithFormat:@"%@", [dict objectForKey:@"phoneNumber"]];
    }
    return self;
}

@end
