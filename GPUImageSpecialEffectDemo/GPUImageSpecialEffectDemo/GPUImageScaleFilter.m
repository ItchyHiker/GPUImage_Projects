//
//  GPUImageScaleFilter.m
//  GPUImageSpecialEffectDemo
//
//  Created by yuhua.cheng on 2020/7/11.
//  Copyright © 2020 idealabs. All rights reserved.
//

#import "GPUImageScaleFilter.h"
NSString * const kGPUImageScaleFilterShaderString = SHADER_STRING
(
 attribute vec4 position;
 attribute vec4 inputTextureCoordinate;
 varying vec2 textureCoordinate;
 uniform float time;
 const float PI = 3.1415926;
 void main()
 {
    float duration = 0.6;
    float maxMagnitude  = 0.4;
    float currentTime = mod(time, duration);
    float magnitude = 1.0 + maxMagnitude * abs(sin(currentTime * (PI / duration)));
    gl_Position = vec4(position.x*magnitude, position.y*magnitude, position.zw);
    textureCoordinate = inputTextureCoordinate.xy;
 }
);

@implementation GPUImageScaleFilter

- (id)init {
    self = [super initWithVertexShaderFromString:kGPUImageScaleFilterShaderString fragmentShaderFromString:kGPUImagePassthroughFragmentShaderString];
    timeUniform = [filterProgram uniformIndex:@"time"];
    
    return self;
}

- (void)setTime:(CGFloat)time {
    _time = time;
    [self setFloat:time forUniform:timeUniform program:filterProgram];
}
@end
