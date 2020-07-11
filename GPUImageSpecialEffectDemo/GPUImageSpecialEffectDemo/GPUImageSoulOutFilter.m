//
//  GPUImageSoulOutFilter.m
//  GPUImageSpecialEffectDemo
//
//  Created by yuhua.cheng on 2020/7/11.
//  Copyright © 2020 idealabs. All rights reserved.
//

#import "GPUImageSoulOutFilter.h"
NSString * const kGPUImageSoulOutFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 uniform float time;
 const float PI = 3.1415926;
 void main()
 {
    // timeout duration
    float duration = 0.6;
    // max alpha value
    float maxAlpha = 0.5;
    // max scale
    float maxScale = 1.8;
    // progress value
    float progress = mod(time, duration) / duration; // 0~1
    // alpha range [0, 0.5]
    float alpha = maxAlpha * (1.0 - progress);
    // scale range
    float scale = 1.0 + (maxScale - 1.0) * progress;
    
    // 放大纹理坐标
    // 根据放大比例，得到放大纹理坐标 [0,0],[0,1],[1,1],[1,0]
    float weakX = 0.5 + (textureCoordinate.x - 0.5) / scale;

    float weakY = 0.5 + (textureCoordinate.y - 0.5) / scale;
    // 放大纹理坐标
    vec2 weakTextureCoords = vec2(weakX, weakY);
    
    // 获取对应放大纹理坐标下的纹素(颜色值rgba)
    vec4 weakMask = texture2D(inputImageTexture, weakTextureCoords);
   
    // 原始的纹理坐标下的纹素(颜色值rgba)
    vec4 mask = texture2D(inputImageTexture, textureCoordinate);
    
    // 颜色混合 默认颜色混合方程式 = mask * (1.0-alpha) + weakMask * alpha;
    gl_FragColor = mask * (1.0 - alpha) + weakMask * alpha;
    }
);

@implementation GPUImageSoulOutFilter

- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageSoulOutFilterFragmentShaderString])) {
        return nil;
    }
    return self;
}

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString;
{
    if (!(self = [super initWithFragmentShaderFromString:fragmentShaderString]))
    {
        return nil;
    }
    
    timeUniform = [filterProgram uniformIndex:@"time"];
    return self;
}

- (void)setTime:(CGFloat)time {
    _time = time;
    [self setFloat:_time forUniform:timeUniform program:filterProgram];
}
@end
