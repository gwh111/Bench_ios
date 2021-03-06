//
//  DESTool.h
//  testDES
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_DES : CC_Object

// @param plainText 加密明文
// @param key 密钥 64位
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;

//解密
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;

@end
