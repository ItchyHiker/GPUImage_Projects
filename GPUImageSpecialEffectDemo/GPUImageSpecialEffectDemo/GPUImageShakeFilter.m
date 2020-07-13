//
//  GPUImageShakeFilter.m
//  GPUImageSpecialEffectDemo
//
//  Created by yuhua.cheng on 2020/7/13.
//  Copyright © 2020 idealabs. All rights reserved.
//

#import "GPUImageShakeFilter.h"
NSString * const kGPUImageShakeFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 
 uniform float time;
 
 void main (void) {
    float duration = 0.7;
    float maxScale = 1.2;
    float maxOffset = 0.02;
    
    float progress = mod(time, duration) / duration; // [0, 1]
    vec2 offset = vec2(maxOffset, maxOffset)*progress;
    float scale = 1.0 + (maxScale - 1.0)*progress; // [1, 1.5]
    
    vec2 scaleTextureCoords = vec2(0.5, 0.5) + (textureCoordinate - vec2(0.5, 0.5)) / scale;
    
    vec4 maskR = texture2D(inputImageTexture, scaleTextureCoords + offset);
    vec4 maskG = texture2D(inputImageTexture, scaleTextureCoords - offset);
    vec4 maskB = texture2D(inputImageTexture, scaleTextureCoords);
    gl_FragColor = vec4(maskR.r, maskG.g, maskB.b, maskR.a);
 }
);

@implementation GPUImageShakeFilter

- (id)init {
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageShakeFilterFragmentShaderString])) {
        return nil;
    }
    return self;
}

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString
{
    if (!(self = [super initWithFragmentShaderFromString:fragmentShaderString])) {
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
