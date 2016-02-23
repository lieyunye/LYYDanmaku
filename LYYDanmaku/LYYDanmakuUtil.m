//
//  LYYDanmakuUtil.m
//  LYYDanmaku
//
//  Created by lieyunye on 1/26/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import "LYYDanmakuUtil.h"

@implementation LYYDanmakuUtil

+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font size:(CGSize)size
{
    CGRect stringRect = [str boundingRectWithSize:size
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:@{ NSFontAttributeName : font }
                                          context:nil];
    
    return stringRect.size;
}

@end
