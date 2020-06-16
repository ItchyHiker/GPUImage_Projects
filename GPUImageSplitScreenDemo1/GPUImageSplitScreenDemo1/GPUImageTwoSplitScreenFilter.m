//
//  GPUImageTwoSplitScreenFilter.m
//  GPUImageSplitScreenDemo1
//
//  Created by yuhua.cheng on 2020/6/16.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageTwoSplitScreenFilter.h"

NSString *const kGPUImageTwoSplitScreenFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 
 
 void main() {
     // 纹理坐标
     vec2 uv = textureCoordinate.xy;
     float y;
     if (uv.y >= 0.0 && uv.y <= 0.5) {
         y = uv.y + 0.25;
     } else {
         y = uv.y - 0.25;
     }

     gl_FragColor = texture2D(inputImageTexture, vec2(uv.x, y));
}

);

@implementation GPUImageTwoSplitScreenFilter

- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageTwoSplitScreenFilterFragmentShaderString])) {
        return nil;
    }
    return self;
}

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString;
{
    if (!(self = [super initWithFragmentShaderFromString:fragmentShaderString])) {
        return nil;
    }
    return self;
}

@end

