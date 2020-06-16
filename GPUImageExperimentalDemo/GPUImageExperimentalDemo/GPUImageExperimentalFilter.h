//
//  GPUImageExperimentalFilter.h
//  GPUImageExperimentalDemo
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageExperimentalFilter : GPUImageFilter
{
    GLfloat scaleUniform;
}

@property (nonatomic, readwrite) CGFloat scale;

@end

NS_ASSUME_NONNULL_END
