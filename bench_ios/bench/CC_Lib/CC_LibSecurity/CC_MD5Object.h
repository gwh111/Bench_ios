//
//  AppMD5Object.h
//  AppleToolProj
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_MD5Object : CC_Object

/** 字符串转为md5*/
+ (NSString *)signString:(NSString *)origString;

@end
