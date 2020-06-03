//
//  GPUImageSquareMosaicFilter.h
//  GPUImageMosaicFilter
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageSquareMosaicFilter : GPUImageFilter
{
    GLfloat imageWidthFactorUniform, imageHeightFactorUniform;
}

@property (nonatomic, readwrite) CGFloat imageWdithFactor;
@property (nonatomic, readwrite) CGFloat imageHeightFactor;

@end

NS_ASSUME_NONNULL_END
