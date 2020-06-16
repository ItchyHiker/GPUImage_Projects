//
//  GPUImageBlurSplitScreenFilter.m
//  GPUImageSplitScreenDemo1
//
//  Created by yuhua.cheng on 2020/6/16.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageBlurSplitScreenFilter.h"
NSString *const kGPUImageBlurSplitScreenFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform float blurOffsetY;  // y轴边框模糊偏移值
 uniform float scale;        // 模糊部分的缩放倍数
 
 void main() {
     // 纹理坐标
     vec2 uv = textureCoordinate.xy;
     vec4 color;
    
     if (uv.y >= blurOffsetY && uv.y <= 1.0 - blurOffsetY) {
         color = texture2D(inputImageTexture, uv);
     } else {
         vec2 center = vec2(0.5, 0.5);
         uv -= center;
         uv = uv / scale;
         uv += center;
         color = texture2D(inputImageTexture2, uv);
     }

    gl_FragColor = color;
}
);


@implementation GPUImageBlurSplitScreenFilter

- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageBlurSplitScreenFilterFragmentShaderString])) {
        return nil;
    }
    return self;
}

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString
{
    if (!(self = [super initWithFragmentShaderFromString:fragmentShaderString])) {
        return nil;
    }
    scaleUniform = [filterProgram uniformIndex:@"scale"];
    blurOffsetYUniform = [filterProgram uniformIndex:@"blurOffsetY"];
    
    return self;
}

- (void)setScale:(CGFloat)newValue
{
    _scale = newValue;
    [self setFloat:_scale forUniform:scaleUniform program:filterProgram];
}

- (void)setBlurOffsetY:(CGFloat)newValue
{
    _blurOffsetY = newValue;
    [self setFloat:_blurOffsetY forUniform:blurOffsetYUniform program:filterProgram];
}

@end
