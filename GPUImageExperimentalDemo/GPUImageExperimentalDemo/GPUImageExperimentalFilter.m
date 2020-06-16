//
//  GPUImageExperimentalFilter.m
//  GPUImageExperimentalDemo
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageExperimentalFilter.h"

NSString *const kGPUImageExperimentalFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 uniform float scale;

 void main() {
    float shift = 1.5;
    vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    vec2 shift1 = vec2(-0.05 * scale, -0.05 * scale);
    vec2 shift2 = vec2(-0.1 * scale, -0.1 * scale);
    vec4 shiftColor1 = texture2D(inputImageTexture, textureCoordinate + shift1);
    vec4 shiftColor2 = texture2D(inputImageTexture, textureCoordinate + shift2);
    
    vec3 blendFirstColor = vec3(textureColor.r, textureColor.g, shiftColor1.b);
    vec3 blendColor = vec3(shiftColor2.r, textureColor.g, shiftColor1.b);
    
    gl_FragColor = vec4(blendColor, textureColor.a);
}
);

@implementation GPUImageExperimentalFilter


- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageExperimentalFilterFragmentShaderString])) {
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
    
    return self;
}

- (void)setScale:(CGFloat)newValue
{
    _scale = newValue;
    [self setFloat:_scale forUniform:scaleUniform program:filterProgram];
}
@end
