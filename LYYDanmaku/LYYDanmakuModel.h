//
//  LYYDanmakuModel.h
//  LYYDanmaku
//
//  Created by lieyunye on 1/26/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYYDanmakuModel : NSObject
@property (nonatomic, assign) NSInteger danmakuID;
@property (nonatomic, assign) NSInteger postID;
@property (nonatomic, assign) NSInteger videoID;
@property (nonatomic, assign) NSInteger videoPosition;
@property (nonatomic ,copy) NSString *soundUrlString;
@property (nonatomic ,copy) NSURL *localAudioFileUrl;
@property (nonatomic, copy) NSString *danmakuContent;
@property (nonatomic, assign) NSInteger danmakuSnapCreateTime;
@property (nonatomic ,copy) NSString *danmakuSnapImageUrlString;
@property (nonatomic ,copy) NSString *danmakuThumbSnapImageUrlString;
@property (nonatomic, assign) NSInteger isSoundDanmaku;
@property (nonatomic, assign) NSInteger audioDuration;
@property (nonatomic, assign) NSInteger danmakuCreateTime;
@property (nonatomic, assign) NSInteger danmakuLikeCount;
@property (nonatomic, assign) NSInteger isShowLike;
@property (nonatomic, assign) NSInteger isLiked;
@property (nonatomic, assign) NSInteger isAmazingDanmaku;
@property (nonatomic, assign) NSInteger likeWeight;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
