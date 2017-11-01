//
//  AppDelegate.h
//  yoyo
//
//  Created by 辛忠志 on 2017/5/19.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

/**
 设置所有的属性为可选(所有属性值可以为空)

 @param propertyName 辛忠志

 @return 2016 10 27 
 */
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
