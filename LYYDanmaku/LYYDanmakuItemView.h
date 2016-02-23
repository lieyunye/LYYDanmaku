//
//  LYYDanmakuItemView.h
//  LYYDanmaku
//
//  Created by lieyunye on 1/26/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYYDanmakuModel.h"

@protocol LYYDanmakuItemViewDelegate <NSObject>

- (void)didClickDanmaku:(LYYDanmakuModel *)model;

@end

@interface LYYDanmakuItemView : UIView
@property (nonatomic, strong) LYYDanmakuModel *model;
@property (nonatomic, assign) id<LYYDanmakuItemViewDelegate> delegate;
@property (nonatomic, assign) CGFloat velocity;
- (void)configWithModel:(LYYDanmakuModel *)model;
+ (CGFloat)itemHeight;
- (void)fire;
- (void)pause;
-(void)resume;
- (void)stop;
- (void)clickAction;


@end
