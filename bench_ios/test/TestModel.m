//
//  TestModel.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (void)cc_update{
    CCLOG(@"%@ %@",self.cc_modelDictionary,self.cc_modelDictionary[@"str1"]);
    
}

- (void)dealloc {
    CCLOG(@"dealloc");
}

@end

@implementation TestSubModel

@end

@implementation TestSubArrayModel

@end
