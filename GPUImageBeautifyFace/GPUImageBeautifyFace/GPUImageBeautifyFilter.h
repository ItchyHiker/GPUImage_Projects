//
//  GPUImageBeautifyFilter.h
//  GPUImageBeautifyFace
//
//  Created by yuhua.cheng on 2020/5/19.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageThreeInputFilter.h"
#import "GPUImage/GPUImage.h"

NS_ASSUME_NONNULL_BEGIN
@class GPUImageCombinationFilter;

@interface GPUImageBeautifyFilter : GPUImageFilterGroup
{
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}

@end

NS_ASSUME_NONNULL_END
