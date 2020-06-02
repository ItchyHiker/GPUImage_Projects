//
//  ViewController.m
//  GPUImageSobelDetectionDemo
//
//  Created by yuhua.cheng on 2020/6/2.
//  Copyright © 2020 vincent. All rights reserved.
//

// https://objccn.io/issue-21-8/

#import "ViewController.h"
#import "GPUImage.h"

@interface ViewController ()
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageSobelEdgeDetectionFilter *filter;
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;
@property (nonatomic, strong) GPUImageView *filterView;

@property (nonatomic , strong) CADisplayLink *mDisplayLink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    _filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
    _filter.edgeStrength = 2;
    
    _filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = _filterView;
    
    [_videoCamera addTarget:_filter];
    [_filter addTarget:_filterView];
    
    [_videoCamera startCameraCapture];
}


@end
