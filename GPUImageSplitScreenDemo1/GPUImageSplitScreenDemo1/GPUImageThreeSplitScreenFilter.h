//
//  GPUImageThreeSplitScreenFilter.h
//  GPUImageSplitScreenDemo1
//
//  Created by yuhua.cheng on 2020/6/16.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageThreeSplitScreenFilter : GPUImageFilter
{
    GLfloat scaleUniform;
}
@property (nonatomic, readwrite) CGFloat scale;
@end

NS_ASSUME_NONNULL_END
