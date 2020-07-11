//
//  GPUImageScaleFilter.h
//  GPUImageSpecialEffectDemo
//
//  Created by yuhua.cheng on 2020/7/11.
//  Copyright © 2020 idealabs. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageScaleFilter : GPUImageFilter
{
    GLfloat timeUniform;
}

@property (nonatomic, readwrite) CGFloat time;
@end

NS_ASSUME_NONNULL_END
