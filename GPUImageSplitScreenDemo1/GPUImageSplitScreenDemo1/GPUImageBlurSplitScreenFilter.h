//
//  GPUImageBlurSplitScreenFilter.h
//  GPUImageSplitScreenDemo1
//
//  Created by yuhua.cheng on 2020/6/16.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageTwoInputFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageBlurSplitScreenFilter : GPUImageTwoInputFilter
{
    GLfloat blurOffsetYUniform, scaleUniform;
}

@property (nonatomic, readwrite) CGFloat blurOffsetY;
@property (nonatomic, readwrite) CGFloat scale;

@end

NS_ASSUME_NONNULL_END
