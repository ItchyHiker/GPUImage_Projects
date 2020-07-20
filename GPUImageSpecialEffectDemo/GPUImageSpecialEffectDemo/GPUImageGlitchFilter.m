//
//  GPUImageGlitchFilter.m
//  GPUImageSpecialEffectDemo
//
//  Created by yuhua.cheng on 2020/7/13.
//  Copyright © 2020 idealabs. All rights reserved.
//

#import "GPUImageGlitchFilter.h"
NSString * const kGPUImageGlitchFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 uniform float time;
 const float PI = 3.1415926;
 // random function
 float mrand(float n) {
    // fract(x) return the decimal of x
    return fract(sin(n) * 43758.5453123);
 }
 
 void main (void) {
    float maxJitter = 0.06;
    float duration  = 0.3;
    float colorROffset = 0.01;
    float colorGOffset = -0.02;
    float colorBOffset = -0.035;
    
    float currentTime = mod(time, duration*2.0); // [0, 1]
    float amplitude = max( sin( currentTime*(PI/duration) ) , 0.0); // [0, 1]
    float jitter = rand(textureCoordinate.y) * 2.0 - 1.0; // [-1, 1]
    bool needOffsets = abs(jitter) < maxJitter * amplitude;
    
    float textureX = textureCoordinate.x + (needOffsets ? jitter : (jitter * amplitude * 0.006));
    vec2 textureCoords = vec2(textureX, textureCoordinate.y);
    
    vec4 mask = texture2D(inputImageTexture, textureCoords);
    vec4 maskR = texture2D(inputImageTexture, textureCoords + vec2(colorROffset * amplitude, 0.0));
    vec4 maskG = texture2D(inputImageTexture, textureCoords + vec2(colorGOffset * amplitude, 0.0));
    vec4 maskB = texture2D(inputImageTexture, textureCoords + vec2(colorBOffset * amplitude, 0.0));
    gl_FragColor = vec4(maskR.r, maskG.g, maskB.b, mask.a);
 }
);
@implementation GPUImageGlitchFilter
- (id)init {
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageGlitchFilterFragmentShaderString])) {
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
