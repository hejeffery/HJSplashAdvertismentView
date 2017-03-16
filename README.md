# HJSplashAdvertismentView

![npm](https://img.shields.io/badge/HJSplashAdvertismentView-1.0.0-brightgreen.svg)
![Travis](https://img.shields.io/travis/rust-lang/rust.svg)
![npm](https://img.shields.io/badge/pod-v1.0.0-blue.svg)
![npm](https://img.shields.io/badge/License-MIT-lightgrey.svg)

* A simple advertisment splash view for iOS. iOS启动页的广告展示View

##功能
* 6行代码实现iOS启动页的广告展示。支持点击事件。


##预览


<img height="480" src="https://github.com/hejeffery/HJSplashAdvertismentView/raw/master/gif/HJSplashAdvertismentView.gif" />


##版本要求
iOS 7 or later


##编译要求
Xcode6+,
OS X 10.7+

##安装
* 1.CocoaPods

#### Podfile

```objective-c
platform :ios, '7.0'
pod 'HJSplashAdvertismentView'
```

* 2.Carthage
  暂不支持

##集成
* 1.导入HJSplashAdvertisment.h

```objective-c
#import "HJSplashAdvertisment.h"
```

* 2.使用

```objective-c
// 集成HJSplashAdvertisment
// 初始化HJSplashAdvertismentModel
HJSplashAdvertismentModel *splashAdvertismentModel = [[HJSplashAdvertismentModel alloc] init];
splashAdvertismentModel.imageURL = @"http://gb.cri.cn/mmsource/images/2005/08/04/pa050804100.jpg";// 图片地址
    
// 初始化HJSplashAdvertismentView
HJSplashAdvertismentView *splashView = [[HJSplashAdvertismentView alloc] init];
splashView.timeDuration = 3.0;// 设置时间，默认是3秒
splashView.splashAdvertismentModel = splashAdvertismentModel;// 设置模型数据
splashView.delegate = self;// 设置代理
splashView.direction = LowerRightDirection;// 设置按钮的方向，支持"右下"，"右上"，"左上"，"左下"，默认是"右下"
[splashView showInView:self.window];

// 处理事件点击
- (void)splashAdvertismentView:(HJSplashAdvertismentView *)splashAdvertismentView
             imageViewDidClick:(UIImageView *)imageView {
    // Do Nothing
}
```


#License
HJSplashAdvertismentView is available under the MIT license. See the LICENSE file for more info.


