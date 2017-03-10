//
//  HJSplashAdvertismentModel.m
//  HJSplashAdvertismentView
//
//  Created by HeJeffery on 2017/3/9.
//  Copyright © 2017年 HeJeffery. All rights reserved.
//

#import "HJSplashAdvertismentModel.h"

@implementation HJSplashAdvertismentModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)splashAdvertismentModel:(NSDictionary *)dict {
    return [[HJSplashAdvertismentModel alloc] initWithDict:dict];
}

@end
