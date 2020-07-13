//
//  GPUImageShineWhiteFilter.m
//  GPUImageSpecialEffectDemo
//
//  Created by yuhua.cheng on 2020/7/13.
//  Copyright © 2020 idealabs. All rights reserved.
//

#import "GPUImageShineWhiteFilter.h"
NSString * const kGPUImageShineWhiteFragmentShaderString = SHADER_STRING
(
 precision highp float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform float time;
 const float PI = 3.1415926;
 void main(void) {
    float duration = 0.5;
    float currentTime = mod(time, duration);
    vec4 whiteMask = vec4(1.0, 1.0, 1.0, 1.0);
    float amplitude = abs(sin(time * (PI / duration)));
    vec4 mask = texture2D(inputImageTexture, textureCoordinate);
    gl_FragColor = mask * (1.0 - amplitude) + whiteMask * amplitude;
 }
);

@implementation GPUImageShineWhiteFilter
- (id)init {
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageShineWhiteFragmentShaderString])) {
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
