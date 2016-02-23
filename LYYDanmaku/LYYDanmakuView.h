//
//  LYYDanmakuView.h
//  LYYDanmaku
//
//  Created by lieyunye on 1/25/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYYDanmakuModel.h"

@protocol LYYDanmakuViewDelegate <NSObject>

- (void)didClickDanmaku:(LYYDanmakuModel *)model;

@end


@interface LYYDanmakuView : UIView
@property (nonatomic, assign) id<LYYDanmakuViewDelegate> delegate;
@property (nonatomic, strong) LYYDanmakuModel *danmakuModel;
- (void)loadDanmakuWithCurrentPlayTime:(NSInteger)currentTime;
- (void)resumeTracks;
- (void)pauseTracks;
- (void)clearDanmakuItems;
- (void)showDanmaku:(LYYDanmakuModel *)model;

@end
