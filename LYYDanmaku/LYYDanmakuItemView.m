//
//  LYYDanmakuItemView.m
//  LYYDanmaku
//
//  Created by lieyunye on 1/26/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import "LYYDanmakuItemView.h"
#import "LYYDanmakuUtil.h"

@interface LYYDanmakuItemView ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIButton *likeNumberBtn;
@property (strong, nonatomic) UIImageView *micro;
@end

@implementation LYYDanmakuItemView
{
    CAAnimation *_animationViewPosition;
    NSArray *_backGroudColors;
}

+ (CGFloat)itemHeight
{
    return 26;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = NO;
        _velocity = 100;
//        _backGroudColors = [NSArray arrayWithObjects:COLOR_ALPHA_HEX(0x00b4ff, 0.5), COLOR_ALPHA_HEX(0x7208d5, 0.5),COLOR_ALPHA_HEX(0x268608, 0.5),COLOR_ALPHA_HEX(0xffc600, 0.5),nil];
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImage *microImage = [UIImage imageNamed:@"video_barrage_microphone"];
        _micro = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, microImage.size.width, microImage.size.height)];
        _micro.image = microImage;
        _micro.hidden = YES;
        [self addSubview:_micro];
        _micro.userInteractionEnabled = NO;
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentLabel];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.shadowOffset = CGSizeMake(1, 1);
        _contentLabel.shadowColor = [UIColor blackColor];

        _likeNumberBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [self addSubview:_likeNumberBtn];
        [_likeNumberBtn setImage:[UIImage imageNamed:@"video_barrage_zan"] forState:UIControlStateNormal];
        NSInteger index = arc4random() % (_backGroudColors.count);
        _likeNumberBtn.backgroundColor = _backGroudColors[index];

        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationDidBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationWillResignActiveNotification) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)clickAction
{
    if ([_delegate respondsToSelector:@selector(didClickDanmaku:)]) {
        [_delegate didClickDanmaku:_model];
    }
}

- (void)configWithModel:(LYYDanmakuModel *)model
{
    CGRect selfFrame = self.frame;
    selfFrame.size.height = _micro.frame.size.height + 10;

    CGFloat frontBackSpace = 10;
    CGRect microFrame = _micro.frame;
    microFrame.origin.x = frontBackSpace;
    _micro.frame = microFrame;
    
    _model = model;
    _contentLabel.text = model.danmakuContent;
    UIFont *contentFont = [UIFont systemFontOfSize:16];
    _contentLabel.font = contentFont;
    CGSize contentSize = [LYYDanmakuUtil getSizeWithString:model.danmakuContent withFont:contentFont size:CGSizeMake(MAXFLOAT, [[self class] itemHeight])];
    CGRect contentLabelFrame = _contentLabel.frame;
    if (model.isSoundDanmaku) {
        _micro.hidden = NO;
        contentLabelFrame.origin.x = _micro.frame.origin.x + CGRectGetWidth(_micro.frame) + 5;
    }else {
        contentLabelFrame.origin.x = _micro.frame.origin.x;
    }
    contentLabelFrame.size.height = contentSize.height;
    contentLabelFrame.size.width = contentSize.width;
    contentLabelFrame.origin.y = (CGRectGetHeight(selfFrame) - CGRectGetHeight(contentLabelFrame)) / 2.0;
    _contentLabel.frame = contentLabelFrame;
    
    _micro.center = CGPointMake(_micro.center.x, _contentLabel.center.y);
    
    _likeNumberBtn.titleLabel.font = contentFont;
    NSString *likeNumberString = [NSString stringWithFormat:@"%ld",model.danmakuLikeCount];
    CGSize likeNumberSize = [LYYDanmakuUtil getSizeWithString:likeNumberString withFont:contentFont size:CGSizeMake(MAXFLOAT, [[self class] itemHeight])];
    
    CGRect likeNumberFrame = _likeNumberBtn.frame;
    CGFloat imageWidth = _likeNumberBtn.imageView.image.size.width;
    NSInteger space = 5;
    likeNumberFrame.origin.x = contentLabelFrame.origin.x + contentLabelFrame.size.width;
    likeNumberFrame.origin.y = (_micro.frame.size.height - _contentLabel.frame.size.height) / 2.0;
    likeNumberFrame.size.height = _contentLabel.frame.size.height;
    
    if (model.isShowLike == 0) {
        likeNumberFrame.size.width = 0;
    }else {
        likeNumberFrame.size.width = likeNumberSize.width + imageWidth + space * 3;
    }
    
    _likeNumberBtn.frame = likeNumberFrame;
    [_likeNumberBtn setTitle:likeNumberString forState:UIControlStateNormal];
    _likeNumberBtn.layer.cornerRadius = likeNumberFrame.size.height / 2.0;
    _likeNumberBtn.layer.masksToBounds = YES;
    [_likeNumberBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
    [_likeNumberBtn setContentEdgeInsets:UIEdgeInsetsMake(0, space, 0, space)];
    
    _likeNumberBtn.center = CGPointMake(_likeNumberBtn.center.x, _contentLabel.center.y);

    selfFrame.size.width = likeNumberFrame.origin.x + likeNumberFrame.size.width + frontBackSpace;
    self.frame = selfFrame;

}

- (void)fire
{
    CALayer *layer = self.layer.presentationLayer;
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    NSTimeInterval t = (CGRectGetWidth(self.bounds) + CGRectGetWidth([UIScreen mainScreen].bounds)) / _velocity;
    [UIView animateWithDuration:t delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame = CGRectMake(-CGRectGetWidth(self.frame), self.frame.origin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)stop
{
    [self pause];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)pause
{
    CALayer *layer = self.layer;
    _animationViewPosition = [[layer animationForKey:@"position"] copy];
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resume
{
    CALayer *layer = self.layer;
    
    if (_animationViewPosition) {
        [layer addAnimation:_animationViewPosition forKey:@"position"];
    }
    
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


- (void)UIApplicationDidBecomeActiveNotification
{
    [self resume];
}

- (void)UIApplicationWillResignActiveNotification
{
    [self pause];
}
@end
