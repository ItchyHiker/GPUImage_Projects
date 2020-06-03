//
//  GPUImageChannelSplitFilter.m
//  GPUImageSplitChannelDemo
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageChannelSplitFilter.h"
NSString *const kGPUImageChannelSplitFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 uniform float intensityX;
 uniform float intensityY;
 
 void main() {
    vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    vec3 color;
    color.r = textureColor.r;
    color.g = texture2D(inputImageTexture, textureCoordinate + vec2(-0.06*intensityX, 0.06*intensityY)).g;
    color.b = texture2D(inputImageTexture, textureCoordinate + vec2(0.06*intensityX, -0.06*intensityY)).b;

//    color.g = texture2D(inputImageTexture, textureCoordinate + vec2(0.02, 0.02)).g;
//    color.b = texture2D(inputImageTexture, textureCoordinate + vec2(-0.02, -0.02)).b;
    
    gl_FragColor = vec4(color, textureColor.a);
}
);
@implementation GPUImageChannelSplitFilter

//@synthesize intensityX = _intensityX;
//@synthesize intensityY = _intensityY;


- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageChannelSplitFragmentShaderString])) {
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
    
    intensityXUniform = [filterProgram uniformIndex:@"intensityX"];
    intensityYUniform = [filterProgram uniformIndex:@"intensityY"];
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setIntensityX:(CGFloat)newValue {
    _intensityX = newValue;
    [self setFloat:_intensityX forUniform:intensityXUniform program:filterProgram];
}

- (void)setIntensityY:(CGFloat)newValue {
    _intensityY = newValue;
    [self setFloat:_intensityY forUniform:intensityYUniform program:filterProgram];
}

@end
