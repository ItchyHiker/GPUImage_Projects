//
//  ViewController.m
//  GPUImagePictureDemo
//
//  Created by yuhua.cheng on 2020/5/18.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import <GPUImageView.h>
#import <GPUImagePicture.h>
#import <GPUImageSepiaFilter.h>
#import <GPUImageTiltShiftFilter.h>
#import <GPUImagePixellateFilter.h>

@interface ViewController ()
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
//@property (nonatomic, strong) GPUImageTiltShiftFilter *tiltShiftFilter;
@property (nonatomic, strong) GPUImagePixellateFilter *tiltShiftFilter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GPUImageView *gpuImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = gpuImageView;
    UIImage *inputImage = [UIImage imageNamed:@"face.png"];
    _sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage];
//    _tiltShiftFilter = [[GPUImageTiltShiftFilter alloc] init];
//    _tiltShiftFilter.blurRadiusInPixels = 40.0;
//    [_tiltShiftFilter forceProcessingAtSize:gpuImageView.sizeInPixels];
    
    _tiltShiftFilter.fractionalWidthOfAPixel = 0.01;
    _tiltShiftFilter = [[GPUImagePixellateFilter alloc] init];
    
    [_sourcePicture addTarget:_tiltShiftFilter];
    [_tiltShiftFilter addTarget:gpuImageView];
    [_sourcePicture processImage];
    
    // GPUImageContext相关的数据显示
    GLint size = [GPUImageContext maximumTextureSizeForThisDevice];
    GLint unit = [GPUImageContext maximumTextureUnitsForThisDevice];
    GLint vector = [GPUImageContext maximumVaryingVectorsForThisDevice];
    NSLog(@"%d %d %d", size, unit, vector);
}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self.view];
//    float rate = point.y /  self.view.frame.size.height;
//    [_tiltShiftFilter setTopFocusLevel:rate - 0.1];
//    [_tiltShiftFilter setBottomFocusLevel:rate + 0.1];
//    [_sourcePicture processImage];
//}


@end
