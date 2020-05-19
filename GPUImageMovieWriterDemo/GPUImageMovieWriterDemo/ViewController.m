//
//  ViewController.m
//  GPUImageMovieWriterDemo
//
//  Created by yuhua.cheng on 2020/5/18.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>
#import <AssetsLibrary/ALAssetsLibrary.h>

@interface ViewController ()
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;
@property (nonatomic, strong) GPUImageView *filterView;

@property (nonatomic, strong) UIButton *mButton;
@property (nonatomic, strong) UILabel *mLabel;
@property (nonatomic, assign) long mLabelTime;
@property (nonatomic, strong) NSTimer *mTimer;

@property (nonatomic, strong) CADisplayLink *mDisplayLink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    _filter = [[GPUImageSepiaFilter alloc] init];
    _filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = _filterView;
    
    _mButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [_mButton setTitle:@"Record" forState:UIControlStateNormal];
    [_mButton sizeToFit];
    [self.view addSubview:_mButton];
    [_mButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _mLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 50, 100)];
    _mLabel.hidden = YES;
    _mLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_mLabel];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 40, 100, 40)];
    [slider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_mLabel];
    
    [_videoCamera addTarget:_filter];
    [_filter addTarget:_filterView];
    [_videoCamera startCameraCapture];
 
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    }];
    
    self.mDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displaylink:)];
    [self.mDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)displaylink:(CADisplayLink *)displaylink {
    NSLog(@"test");
}

- (void)onTimer:(id)sender {
    _mLabel.text = [NSString stringWithFormat:@"record time: %lds", _mLabelTime++];
    [_mLabel sizeToFit];
}

- (void)onClick:(UIButton *)sender {
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie4.m4v"];
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    if ([sender.currentTitle isEqualToString:@"Record"]) {
        [sender setTitle:@"End" forState:UIControlStateNormal];
        unlink([pathToMovie UTF8String]);
        _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480, 640)];
        _movieWriter.encodingLiveVideo = YES;
        [_filter addTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = _movieWriter; // 录制声音
        [_movieWriter startRecording];
        
        _mLabelTime = 0;
        _mLabel.hidden = NO;
        [self onTimer:nil];
        _mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    } else {
        [sender setTitle:@"Record" forState:UIControlStateNormal];
        _mLabel.hidden = YES;
        if (_mTimer) {
            [_mTimer invalidate];
        }
        
        [_filter removeTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = nil;
        [_movieWriter finishRecording];
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie)) {
            [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to save video" message:nil
                                                                            delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successed to save video" message:nil
                                                                            delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                });
            }];
        }
    }
}

- (void)updateSliderValue:(id)sender
{
    [(GPUImageSepiaFilter *)_filter setIntensity:[(UISlider *)sender value]];
}

@end
