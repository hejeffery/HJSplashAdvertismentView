//
//  HJSplashAdvertismentModel.h
//  HJSplashAdvertismentView
//
//  Created by HeJeffery on 2017/3/9.
//  Copyright © 2017年 HeJeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJSplashAdvertismentModel : NSObject

@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *webURL;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)splashAdvertismentModel:(NSDictionary *)dict;

@end
