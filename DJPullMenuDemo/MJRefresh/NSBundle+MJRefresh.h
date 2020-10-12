//
//  NSBundle+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (MJRefresh)
+ (instancetype)mj_refreshBundle;
+ (UIImage *)mj_arrowImage;
+ (UIImage *)mj_trailArrowImage;
@end

NS_ASSUME_NONNULL_END
