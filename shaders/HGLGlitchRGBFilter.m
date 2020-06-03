#import "HGLGlitchRGBFilter.h"

@interface HGLGlitchRGBFilter()

@property (nonatomic, strong) HGLGlitchRGBFilterModel *model;

@end

@implementation HGLGlitchRGBFilter

- (instancetype)initWithModel:(HGLGlitchRGBFilterModel *)model
{
    if (self = [super initWithVertexShaderFile:@"single_input_v" fragmentShaderFile:@"glitch_RGB_f" parameters:@{@"intensityX": @(0.2), @"intensityY": @(0.0)}]) {
        [self.program setParameter:@((double)model.mode) forVar:@"mode"];
        [self.program setParameter:@(model.intensityX) forVar:@"intensityX"];
        [self.program setParameter:@(model.intensityY) forVar:@"intensityY"];
    }
    
    return self;
}

- (void)setIntensity:(float)intensity
{
    [self.program setParameter:@(intensity) forVar:@"scale"];
}

- (void)setHorizontalIntensity:(GLfloat)intensity
{
    [self.program setParameter:@(intensity) forVar:@"intensityX"];
}

- (void)setVerticalIntensity:(GLfloat)intensity
{
    [self.program setParameter:@(intensity) forVar:@"intensityY"];
}


@end

@implementation HGLGlitchRGBFilterModel



@end
