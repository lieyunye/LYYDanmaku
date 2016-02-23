//
//  LYYDanmakuTrackView.h
//  LYYDanmaku
//
//  Created by lieyunye on 1/26/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYYDanmakuItemView.h"
@interface LYYDanmakuTrackView : UIView
- (void)loadItem:(LYYDanmakuItemView *)item;
- (void)pauseItem;
- (void)resumeItem;

@end
