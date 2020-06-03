//
//  GPUImageSquareMosaicFilter.m
//  GPUImageMosaicFilter
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageSquareMosaicFilter.h"

NSString *const kGPUImageSquareMosaicFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 uniform float imageWidthFactor;
 uniform float imageHeightFactor;
 uniform float mosaicSize;
 
 void main() {
    vec2 xy = textureCoordinate.xy;
    vec2 coord = vec2(imageWidthFactor * floor(xy.x / imageWidthFactor), imageHeightFactor * floor(xy.y / imageHeightFactor));
    vec3 color = texture2D(inputImageTexture, coord).xyz;
    gl_FragColor = vec4(color, 1.0);
}
);

@implementation GPUImageSquareMosaicFilter

- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageSquareMosaicFragmentShaderString])) {
        return nil;
    }
    
    return self;
}

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString
{
    if (!(self = [super initWithFragmentShaderFromString:fragmentShaderString])) {
        return nil;
    }
    
    imageWidthFactorUniform = [filterProgram uniformIndex:@"imageWidthFactor"];
    imageHeightFactorUniform = [filterProgram uniformIndex:@"imageHeightFactor"];
  
    return self;
}

- (void)setImageWdithFactor:(CGFloat)newValue
{
    _imageWdithFactor = newValue;
    [self setFloat:_imageWdithFactor forUniform:imageWidthFactorUniform program:filterProgram];
}

- (void)setImageHeightFactor:(CGFloat)newValue
{
    _imageHeightFactor = newValue;
    [self setFloat:_imageHeightFactor forUniform:imageHeightFactorUniform program:filterProgram];
}

@end
