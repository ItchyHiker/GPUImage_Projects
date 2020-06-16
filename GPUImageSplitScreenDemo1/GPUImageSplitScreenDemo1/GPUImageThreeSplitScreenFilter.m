//
//  GPUImageThreeSplitScreenFilter.m
//  GPUImageSplitScreenDemo1
//
//  Created by yuhua.cheng on 2020/6/16.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "GPUImageThreeSplitScreenFilter.h"
NSString *const kGPUImageThreeSplitScreenFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 uniform float scale;
 
 void main() {
    highp vec2 xy = textureCoordinate;
    vec4 color;
    if (xy.y < 1.0 / 3.0) {
        vec2 center = vec2(0.5, 0.5);
        xy -= center;
        xy = xy / scale;
        xy += center;
        color = texture2D(inputImageTexture, xy);
        float gray = 0.3 * color.r + 0.59 * color.g + 0.11 * color.b;
        color = vec4(gray, gray, gray, 1.0);
    } else if (xy.y > 2.0 / 3.0) {
        // 缩放
        vec2 center = vec2(0.5, 0.5);
        xy -= center;
        xy = xy / scale;
        xy += center;
        color = texture2D(inputImageTexture, xy);
        // 黑白图片
        float gray = 0.3 * color.r + 0.59 * color.g + 0.11 * color.b;
        color = vec4(gray, gray, gray, 1.0);
    } else {
        color = texture2D(inputImageTexture, xy);
    }
    gl_FragColor = color;
}
);

@implementation GPUImageThreeSplitScreenFilter

- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageThreeSplitScreenFilterFragmentShaderString])) {
        return nil;
    }
    return self;
}

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString;
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
