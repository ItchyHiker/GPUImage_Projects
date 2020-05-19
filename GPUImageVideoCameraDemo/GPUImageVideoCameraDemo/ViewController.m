//
//  ViewController.m
//  GPUImageVideoCameraDemo
//
//  Created by yuhua.cheng on 2020/5/19.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import "GPUImageView.h"
#import "GPUImageVideoCamera.h"
#import "GPUImageSepiaFilter.h"

@interface ViewController ()
@property (strong, nonatomic) GPUImageView *mGPUImageView;
@property (strong, nonatomic) GPUImageVideoCamera *mGPUVideoCamera;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mGPUImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_mGPUImageView];
    
    self.mGPUVideoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    self.mGPUVideoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.mGPUImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill; // kGPUImageFillModeStretch;
    
    GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc] init];
    [self.mGPUVideoCamera addTarget:filter];
    [filter addTarget:self.mGPUImageView];
    
    [self.mGPUVideoCamera startCameraCapture];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    self.mGPUVideoCamera.outputImageOrientation = orientation;
    self.mGPUImageView.frame = self.view.frame; // 不加这句旋转之后frame没有变化会出问题
}

@end
