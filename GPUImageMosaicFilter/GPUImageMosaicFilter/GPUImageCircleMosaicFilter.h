//
//  GPUImageCircleMosaicFilter.h
//  GPUImageMosaicFilter
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCircleMosaicFilter : GPUImageFilter
{
    GLfloat mosaicSizeUniform;
    GLfloat imageWidthUniform;
    GLfloat imageHeightUniform;
}

@property (nonatomic, readwrite) CGFloat mosaicSize;
@property (nonatomic, readwrite) CGFloat imageWidth;
@property (nonatomic, readwrite) CGFloat imageHeight;

@end

NS_ASSUME_NONNULL_END
