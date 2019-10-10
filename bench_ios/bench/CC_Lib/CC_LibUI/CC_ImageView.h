//
//  CC_ImageView.h
//  CCUILib
//
//  Created by ml on 2019/9/2.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUIScaffold.h"
#import "UIColor+CC.h"

NS_ASSUME_NONNULL_BEGIN

#define IMG_HOLDER_COLOR(WIDTH,HEIGHT,COLOR) [UIColor cc_imageWithColor:COLOR width:WIDTH height:HEIGHT]
#define IMG_HOLDER(WIDTH,HEIGHT) IMG_HOLDER_COLOR(WIDTH,HEIGHT,UIColor.groupTableViewBackgroundColor)

@interface CC_ImageView : UIImageView <CC_ImageView>

/// param 图片路径 Assets.xcassets / Bundle
- (__kindof CC_ImageView *(^)(NSString *))cc_imageNamed;

/// param 图片路径 网络图片
/// param 占位图
- (__kindof CC_ImageView *(^)(NSString *,UIImage *))cc_imageURL;

@end

@interface CC_ImageView (CCActions)

@end

NS_ASSUME_NONNULL_END
