//
//  LYYDanmakuView.m
//  LYYDanmaku
//
//  Created by lieyunye on 1/25/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import "LYYDanmakuView.h"
#import "LYYDanmakuTrackView.h"
#import "LYYDanmakuItemView.h"
#import "LYYDanmakuModel.h"

@interface LYYDanmakuView ()<LYYDanmakuItemViewDelegate>

@end

@implementation LYYDanmakuView
{
    
    BOOL _isPaused;
    NSTimeInterval _lastCurrentTime;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addObservers];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addObservers];
    }
    return self;
}

- (void)layoutSubviews
{
    [self initTracks];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationWillResignActiveNotification) name:UIApplicationWillResignActiveNotification object:nil];
    [self loadDanmaku];
}

- (void)initTracks
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray *trackViewFrameArray = [[NSMutableArray alloc] init];
    CGFloat itemHeight = [LYYDanmakuItemView itemHeight];
    CGFloat itemSpace = 1.0;
    NSInteger count = CGRectGetHeight(self.bounds) / (itemHeight + itemSpace);
    [self initTrackViewWithCount:count];
    for (NSInteger i = 0; i < count; i++) {
        CGRect frame = CGRectMake(0, i * (itemHeight + itemSpace), CGRectGetWidth(self.bounds), itemHeight);
        [trackViewFrameArray addObject:NSStringFromCGRect(frame)];
    }
    [self configTrackViewFrameWithFrames:trackViewFrameArray];
}

- (void)clearDanmakuItems
{
    for (LYYDanmakuTrackView *item in self.subviews) {
        [item.subviews makeObjectsPerformSelector:@selector(stop)];
    }
}

- (void)initTrackViewWithCount:(NSInteger)count
{
    for (NSInteger i = 0; i < count; i++) {
        LYYDanmakuTrackView *trackView = [[LYYDanmakuTrackView alloc] init];
        [self addSubview:trackView];
    }
}

- (void)configTrackViewFrameWithFrames:(NSArray *)frames
{
    for (NSInteger i = 0; i < frames.count; i++) {
        LYYDanmakuTrackView *trackView = self.subviews[i];
        CGRect frame = CGRectFromString(frames[i]);
        trackView.frame = frame;
    }
}

- (void)loadDanmaku
{
    if (_isPaused) {
        return;
    }
    LYYDanmakuModel *model = [[LYYDanmakuModel alloc] init];
    NSString *string = @"在今年苹果不仅将推出三款新iPhone手机，同时其在其他方面也在开始积极布局，前不久刚刚推出了Apple Pay，而现在苹果对iOS系统也开始了新的调整，官方推出了iOS 9.3测试第四版，其更新大小为163MB，其中更新的重点针更倾向于健康，新功能将进一步减少屏幕释放的蓝光";
    NSInteger index = arc4random() % string.length;
    model.danmakuContent = [string substringToIndex:index];
    [self showDanmaku:model];
    [self performSelector:@selector(loadDanmaku) withObject:nil afterDelay:1/5.0];
}

- (void)showDanmaku:(LYYDanmakuModel *)model
{
    if (model.danmakuContent.length == 0) {
        return;
    }
    LYYDanmakuTrackView *trackView = [self findTheRightAndBestTrackView];
    LYYDanmakuItemView *item = [[LYYDanmakuItemView alloc] initWithFrame:CGRectMake(CGRectGetWidth(trackView.frame), 0, 0, [LYYDanmakuItemView itemHeight])];
    item.delegate = self;
    [item configWithModel:model];
    if (trackView) {
        [trackView loadItem:item];
    }
}

- (LYYDanmakuTrackView *)findTheRightAndBestTrackView
{
    for (LYYDanmakuTrackView *trackView in self.subviews) {
        LYYDanmakuItemView *item = trackView.subviews.lastObject;
        if (item) {
            CGRect rect = ((CALayer *)item.layer.presentationLayer).frame;
            CGFloat itemSpaceInTrack = 20;
            if (rect.origin.x != 0 && CGRectGetWidth([UIScreen mainScreen].bounds) - (rect.origin.x + rect.size.width) >= itemSpaceInTrack) {
                return trackView;
            }
        }else {
            return trackView;
        }
    }
    return nil;
}

#pragma mark - LYYDanmakuItemViewDelegate
- (void)didClickDanmaku:(LYYDanmakuModel *)model
{
    if ([_delegate respondsToSelector:@selector(didClickDanmaku:)]) {
        [_delegate didClickDanmaku:model];
    }
}


- (void)resumeTracks
{
    if (_isPaused) {
        _isPaused = NO;
        [self.subviews makeObjectsPerformSelector:@selector(resumeItem)];
    }
}

- (void)pauseTracks
{
    if (_isPaused == NO) {
        _isPaused = YES;
        [self.subviews makeObjectsPerformSelector:@selector(pauseItem)];
        
    }
}

- (void)UIApplicationWillEnterForegroundNotification
{
    //    [self resumeTracks];
}

- (void)UIApplicationWillResignActiveNotification
{
    //    [self pauseTracks];
}
@end
