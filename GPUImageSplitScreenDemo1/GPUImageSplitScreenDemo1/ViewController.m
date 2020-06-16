//
//  ViewController.m
//  GPUImageSplitScreenDemo1
//
//  Created by yuhua.cheng on 2020/6/16.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import "GPUImageView.h"
#import "GPUImageVideoCamera.h"
#import "GPUImageSepiaFilter.h"
#import "GPUImageThreeSplitScreenFilter.h"
#import "GPUImageTwoSplitScreenFilter.h"
#import "GPUImageBlurSplitScreenFilter.h"
#import "GPUImageGaussianBlurFilter.h"

@interface ViewController ()
@property (nonatomic, strong) GPUImageView *mGPUImageView;
@property (nonatomic, strong) GPUImageVideoCamera *mGPUVideoCamera;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mGPUImageView =  [[GPUImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_mGPUImageView];
    
    self.mGPUVideoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    self.mGPUVideoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.mGPUImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    
    // GPUImageFilter *filter = [[GPUImageSepiaFilter alloc] init];
    // GPUImageTwoSplitScreenFilter *filter = [[GPUImageTwoSplitScreenFilter alloc] init];
    // [(GPUImageThreeSplitScreenFilter *)filter setScale:1.5];
    // [self.mGPUVideoCamera addTarget:filter];
    // [filter addTarget:self.mGPUImageView];
    
    GPUImageBlurSplitScreenFilter *splitScreenfilter = [[GPUImageBlurSplitScreenFilter alloc] init];
    [splitScreenfilter setScale:1.5];
    [splitScreenfilter setBlurOffsetY:0.25];
    
    GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    
    [self.mGPUVideoCamera addTarget:blurFilter];
    [self.mGPUVideoCamera addTarget:splitScreenfilter];
    
    [blurFilter addTarget:splitScreenfilter];
    [splitScreenfilter addTarget:self.mGPUImageView];
    [self.mGPUVideoCamera startCameraCapture];
    
}


@end
