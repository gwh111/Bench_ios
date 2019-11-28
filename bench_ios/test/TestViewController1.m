//
//  ViewController.m
//  testbenchios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestViewController1.h"
#import "TestViewController2.h"
#import "CC_Color.h"
#import "CC_Device.h"
#import "TestModel.h"
#import "TestView.h"
#import "TestController.h"
#import "ccs.h"

@interface TestViewController1 ()

@end

@implementation TestViewController1

+ (instancetype)shared{
    return [ccs registerSharedInstance:self block:^{
        // Do init things
    }];
}

- (void)cc_viewWillLoad{
    TestView *imgv = [ccs init:TestView.class];
    ccs.View
    .cc_dragable(YES);
    
    imgv
        .cc_addToView(self.view)
        .cc_frame(100, 200, 50, 50)
    .cc_backgroundColor(HEXA(fff111, 1))
        .cc_badgeValue(@"abc3")
        .cc_badgeColor(UIColor.whiteColor)
        .cc_badgeBgColor(UIColor.redColor);
    
//    [imgv cc_updateBadge:@"abc3"];
//    [imgv cc_updateBadge:@"abc4"];
    
    [imgv test];
    NSData *d=[ccs bundleFileWithPath:@"testjson" type:@"json"];
    NSString *s=[d cc_convertToUTF8String];
    NSDictionary *json=[ccs function_jsonWithString:s];
    
    id vv= [ccs getAView];
    [ccs showNotice:@"aaaa@!#!@#!@#@!#!@#$" atView:vv];
    
    TestModel *t1=[ccs model:[TestModel class]];
    [t1 cc_setProperty:json];
    int v=t1.intv;
    v++;
    
    [t1 cc_setObjectClassInArrayWithDic:@{@"groupUsers":@"TestSubArrayModel"}];
    [t1 cc_setProperty:    @{
                             @"robots" :@(10),
                             @"jumpLogin" :@"",
                             @"nowTimestamp" : @"1568962641534",
                             @"success" : @"",
                             @"group" : @{
                                     @"groupUserCount" : @"",
                                     @"groupName" :@"易辰,清一色,贼牛逼",
                                     @"groupLogoUrl" :@" http://mapi1.mingliao.net/groupLogoUrl.htm?groupId=10164005311021834700740980168678&sizeType=LARGE&timestamp=1568962641641",
                                     },
                             @"nowDate" : @"2019-09-20 14:57:21",
                             @"groupUsers" :@[@{@"groupId" : @"123"}]
                             }];
    [t1 cc_setProperty:@{@"st1":@"1",@"id":@"b",@"model1":@{@"st2":@"abc",@"st1":@"abcsd"}} modelKVDic:@{@"st2":@"id"}];
    [t1 cc_update];
    [@{@"st1":@"1",@"a":@"b"} cc_propertyCode];
    
    CCLOG(@"%@",APP_STANDARD(@"大标题"));
}

- (void)cc_viewDidLoad{
    
    TestViewController2 *vc1 = [ccs init:TestViewController2.class];
    vc1.tests1 = @"";
    [ccs pushViewController:vc1];
    
    CC_View *someView = ccs.View
    .cc_addToView(self.view)
    .cc_name(@"abc")
    .cc_frame(RH(10),RH(100),RH(100),RH(100))
    .cc_backgroundColor(UIColor.whiteColor);
    
    [someView cc_tappedInterval:3 withBlock:^(id  _Nonnull view) {
        [self cc_removeViewWithName:@"abc"];
    }];
    
}

- (void)cc_viewWillAppear {
}

- (id)change:(id)obj{
    return obj;
}

- (void)dealloc
{
    
}
@end
