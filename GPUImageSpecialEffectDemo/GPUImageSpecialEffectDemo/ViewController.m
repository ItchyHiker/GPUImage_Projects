//
//  ViewController.m
//  GPUImageSpecialEffectDemo
//
//  Created by yuhua.cheng on 2020/7/11.
//  Copyright © 2020 idealabs. All rights reserved.
//

#import "ViewController.h"
#import <GPUImageView.h>
#import <GPUImagePicture.h>
#import <GPUImagePixellateFilter.h>
#import <GPUImageVideoCamera.h>
#import "GPUImageScaleFilter.h"
@interface ViewController ()
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
//@property (nonatomic, strong) GPUImagePixellateFilter *channelSplitFilter;
@property (nonatomic, strong) GPUImageScaleFilter *filter;
@property (strong, nonatomic) GPUImageVideoCamera *mGPUVideoCamera;
@property (nonatomic, strong) CADisplayLink *displayLink; // 用于刷新屏幕
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GPUImageView *gpuImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = gpuImageView;
    UIImage *inputImage = [UIImage imageNamed:@"face.jpg"];
    _sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    self.mGPUVideoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    self.mGPUVideoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    
//    _filter = [[GPUImagePixellateFilter alloc] init];
    _filter = [[GPUImageScaleFilter alloc] init];
    [_sourcePicture addTarget: _filter];
//    [_mGPUVideoCamera addTarget:_filter];
    [_filter addTarget:gpuImageView];
    
    [_sourcePicture processImage];
//    [_mGPUVideoCamera startCameraCapture];
    
    [self startFilerAnimation];
}


- (void)startFilerAnimation {
    // 1.判断displayLink 是否为空
    // CADisplayLink 定时器
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    // 2. 设置displayLink 的方法
    // self.startTimeInterval = 0;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeAction)];
    
    // 3.将displayLink 添加到runloop 运行循环
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop]
                           forMode:NSRunLoopCommonModes];
}

- (void)timeAction {
    // DisplayLink 的当前时间戳
    CGFloat currentTime = self.displayLink.timestamp;
    [_filter setTime:currentTime];
    [_sourcePicture processImage];
}

@end
