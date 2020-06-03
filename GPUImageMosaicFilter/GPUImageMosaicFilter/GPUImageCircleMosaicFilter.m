//
//  GPUImageCircleMosaicFilter.m
//  GPUImageMosaicFilter
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageCircleMosaicFilter.h"

NSString *const kGPUImageCircleMosaicFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 uniform float mosaicSize;
 uniform float imageWidth;
 uniform float imageHeight;
 
 void main() {
    vec2 texSize = vec2(imageWidth, imageHeight);
    vec2 xy = vec2(textureCoordinate.x * texSize.x, textureCoordinate.y * texSize.y);
    vec2 center = vec2(mosaicSize * floor(xy.x / mosaicSize) + 0.5*mosaicSize, mosaicSize * floor(xy.y / mosaicSize) + 0.5*mosaicSize);
    float dist = length(center - xy);
    vec4 color;
    
    vec2 coord = vec2(center.x / texSize.x, center.y / texSize.y);
    
    if (dist < 0.5*mosaicSize) {
        color = texture2D(inputImageTexture, coord);
    } else {
        color = texture2D(inputImageTexture, textureCoordinate);
    }
    gl_FragColor = color;
}
);

@implementation GPUImageCircleMosaicFilter

- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageCircleMosaicFragmentShaderString])) {
        return nil;
    }
    
    return self;
}

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString
{
    if (!(self = [super initWithFragmentShaderFromString:fragmentShaderString])) {
        return nil;
    }
    
    mosaicSizeUniform = [filterProgram uniformIndex:@"mosaicSize"];
    imageWidthUniform = [filterProgram uniformIndex:@"imageWidth"];
    imageHeightUniform = [filterProgram uniformIndex:@"imageHeight"];
    
    return self;
}

- (void)setMosaicSize:(CGFloat)newValue
{
    _mosaicSize = newValue;
    [self setFloat:_mosaicSize forUniform:mosaicSizeUniform program:filterProgram];
}

- (void)setImageWidth:(CGFloat)newValue
{
    _imageWidth = newValue;
    [self setFloat:_imageWidth forUniform:imageWidthUniform program:filterProgram];
}

- (void)setImageHeight:(CGFloat)newValue
{
    _imageHeight = newValue;
    [self setFloat:_imageHeight forUniform:imageHeightUniform program:filterProgram];
}

@end
