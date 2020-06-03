//
//  GPUImageChannelSplitFilter.h
//  GPUImageSplitChannelDemo
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageChannelSplitFilter : GPUImageFilter
{
    GLfloat intensityXUniform, intensityYUniform;
}

@property (nonatomic, readwrite) CGFloat intensityX, intensityY;
@end

NS_ASSUME_NONNULL_END
