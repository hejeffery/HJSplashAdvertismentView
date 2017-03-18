//
//  HJSplashAdvertismentView.m
//  HJSplashAdvertismentView
//
//  Created by HeJeffery on 2017/3/9.
//  Copyright © 2017年 HeJeffery. All rights reserved.
//

#import "HJSplashAdvertismentView.h"
#import "Masonry.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

// button的宽度
static const CGFloat kButtonW = 65.0f;
// button的高度
static const CGFloat kButtonH = 28.0f;

// button的上下边距
static const CGFloat kMargin = 30.0f;
// button的左右边距
static const CGFloat kPadding = 25.0f;

// 倒计时的步长
static const NSUInteger kStepTime = 1;
// 动画时长
static const CGFloat kAnimationDuration = 0.25f;
// 默认时长
static const NSUInteger kDefaultDuration = 3;

@interface HJSplashAdvertismentView ()

@property (nonatomic, weak) UIImageView *splashImageView;

@property (nonatomic, weak) UIButton *countdownButton;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation HJSplashAdvertismentView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.timeDuration = kDefaultDuration;
    
    self.countdownBackgroundColor = [UIColor colorWithRed:(0)/255.0 green:(0)/255.0 blue:(0)/255.0 alpha:(153.0)/255.0];
    
    self.countdownTitleColor = [UIColor whiteColor];
    
    self.tipString = @"跳过";
    
    self.direction = LowerRightDirection;
    
    self.frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    [self setupSubViews];
    
    [self setupLayouts];
}

- (void)setupSubViews {
    UIImageView *splashImageView = [[UIImageView alloc] init];
    splashImageView.contentMode = UIViewContentModeScaleAspectFill;
    splashImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tapGesture:)];
    [splashImageView addGestureRecognizer:tapGestureRecognizer];
    [self addSubview:splashImageView];
    self.splashImageView = splashImageView;
    
    UIButton *countdownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    countdownButton.backgroundColor = self.countdownBackgroundColor;
    [countdownButton setTitleColor:self.countdownTitleColor forState:UIControlStateNormal];
    countdownButton.titleLabel.font = [UIFont systemFontOfSize:13.5f];
    countdownButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [countdownButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    countdownButton.layer.cornerRadius = kButtonH * 0.5;
    countdownButton.layer.masksToBounds = YES;
    [countdownButton sizeToFit];
    [self addSubview:countdownButton];
    self.countdownButton = countdownButton;
}

- (void)setupLayouts {
    // 设置布局
    [self.splashImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.countdownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-kMargin);
        make.width.mas_equalTo(kButtonW);
        make.height.mas_equalTo(kButtonH);
        make.right.equalTo(self.mas_right).offset(-kPadding);
    }];
}

- (void)showInView:(UIView *)view {

    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    // 通过缓存的key找到图片，找到了才显示HJSplashAdvertismentView
    UIImage *splashImage = [imageCache imageFromDiskCacheForKey:self.splashAdvertismentModel.imageURL];
    if (splashImage) {

        [view addSubview:self];

        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.alpha = 1.0f;

        } completion:^(BOOL finished) {

            // 使用GCD定时
            if (self.timeDuration <= 0) {
                self.timeDuration = kDefaultDuration;
            }
            
            dispatch_queue_t queue = dispatch_queue_create("com.hejeffery.splashadvertisment", DISPATCH_QUEUE_CONCURRENT);
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, kStepTime * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(self.timer, ^{
                
                if (self.timeDuration > 0) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        NSString *title = [NSString stringWithFormat:@"%ld %@", (long)self.timeDuration, self.tipString];
                        [self.countdownButton setTitle:title forState:UIControlStateNormal];
                    });
                    
                } else {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self hideAnimation];
                    });
                    // 时间到了，让定时器失效
                    [self invalidateTimer];
                }
                self.timeDuration--;
                
            });
            dispatch_resume(self.timer);
        }];
    }
}

- (void)hideAnimation {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)invalidateTimer {
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = NULL;
    }
}

- (void)buttonAction:(UIButton *)button {
    [self invalidateTimer];
    [self hideAnimation];
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(splashAdvertismentView:imageViewDidClick:)]) {
        [self.delegate splashAdvertismentView:self imageViewDidClick:self.splashImageView];
    }
}

- (void)setSplashAdvertismentModel:(HJSplashAdvertismentModel *)splashAdvertismentModel {
    _splashAdvertismentModel = splashAdvertismentModel;
    [self.splashImageView sd_setImageWithURL:[NSURL URLWithString:splashAdvertismentModel.imageURL] placeholderImage:nil];
}

- (void)setDirection:(SplashButtonDirection)direction {
    _direction = direction;
    
    if (direction == LowerRightDirection) {
        [self.countdownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-kMargin);
            make.width.mas_equalTo(kButtonW);
            make.height.mas_equalTo(kButtonH);
            make.right.equalTo(self.mas_right).offset(-kPadding);
        }];
        
    } else if (direction == UpperRightDirection) {
        [self.countdownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(kMargin);
            make.width.mas_equalTo(kButtonW);
            make.height.mas_equalTo(kButtonH);
            make.right.equalTo(self.mas_right).offset(-kPadding);
        }];
        
    } else if (direction == UpperLeftDirection) {
        [self.countdownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(kMargin);
            make.width.mas_equalTo(kButtonW);
            make.height.mas_equalTo(kButtonH);
            make.left.equalTo(self.mas_left).offset(kPadding);
        }];
        
    } else {
        [self.countdownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-kMargin);
            make.width.mas_equalTo(kButtonW);
            make.height.mas_equalTo(kButtonH);
            make.left.equalTo(self.mas_left).offset(kPadding);
        }];
    }
}

- (void)setCountdownBackgroundColor:(UIColor *)countdownBackgroundColor {
    _countdownBackgroundColor = countdownBackgroundColor;
    self.countdownButton.backgroundColor = countdownBackgroundColor;
}

- (void)setCountdownTitleColor:(UIColor *)countdownTitleColor {
    _countdownTitleColor = countdownTitleColor;
    [self.countdownButton setTitleColor:countdownTitleColor forState:UIControlStateNormal];
}

@end
