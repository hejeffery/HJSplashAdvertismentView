//
//  HJSplashAdvertismentView.h
//  HJSplashAdvertismentView
//
//  Created by HeJeffery on 2017/3/9.
//  Copyright © 2017年 HeJeffery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJSplashAdvertismentModel.h"

// “跳过”按钮的方向
typedef NS_ENUM(NSUInteger, SplashButtonDirection) {
    LowerRightDirection,// 右下
    UpperRightDirection,// 右上
    UpperLeftDirection,// 左上
    LowerLeftDirection// 左下
};

@protocol HJSplashAdvertismentViewDelegate;

/*!
 @class
 @abstract 闪屏广告View
 */
@interface HJSplashAdvertismentView : UIView

/*!
 @property
 @abstract 持续的时间，默认是3秒钟
 */
@property (nonatomic, assign) NSUInteger timeDuration;

/*!
 @property
 @abstract 倒计时按钮的背景，默认是黑色透明背景
 */
@property (nonatomic, strong) UIColor *countdownBackgroundColor;

/*!
 @property
 @abstract 提示的字符串，默认是“跳过”
 */
@property (nonatomic, copy) NSString *tipString;

/*!
 @property
 @abstract “跳过”按钮的方向，默认是右下
 */
@property (nonatomic, assign) SplashButtonDirection direction;

/*!
 @property
 @abstract HJSplashAdvertismentModel
 */
@property (nonatomic, strong) HJSplashAdvertismentModel *splashAdvertismentModel;

/*!
 @method
 @abstract 显示
 @discussion 显示
 
 @param view 添加的View，通常是Window
 
 */
- (void)showInView:(UIView *)view;

@property (nonatomic, weak) id<HJSplashAdvertismentViewDelegate> delegate;

@end

@protocol HJSplashAdvertismentViewDelegate <NSObject>

- (void)splashAdvertismentView:(HJSplashAdvertismentView *)splashAdvertismentView
             imageViewDidClick:(UIImageView *)imageView;

@end
