//
//  LYYDanmakuTrackView.m
//  LYYDanmaku
//
//  Created by lieyunye on 1/26/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import "LYYDanmakuTrackView.h"

@implementation LYYDanmakuTrackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)loadItem:(LYYDanmakuItemView *)item
{
    [self addSubview:item];
    [item fire];
}

- (void)pauseItem
{
    [self.subviews makeObjectsPerformSelector:@selector(pause)];
}

- (void)resumeItem
{
    [self.subviews makeObjectsPerformSelector:@selector(resume)];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint point = [[touches anyObject] locationInView:self];

    for (LYYDanmakuItemView *animatingView in self.subviews) {
        CGRect rect = ((CALayer *)animatingView.layer.presentationLayer).frame;
        if(CGRectContainsPoint(rect, point)){
            [animatingView clickAction];
        }
    }
}



@end
