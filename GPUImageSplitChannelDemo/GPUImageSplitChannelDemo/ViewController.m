//
//  ViewController.m
//  GPUImageSplitChannelDemo
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import <GPUImageView.h>
#import <GPUImagePicture.h>
#import <GPUImagePixellateFilter.h>
#import "GPUImageChannelSplitFilter.h"

@interface ViewController ()
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
@property (nonatomic, strong) GPUImageChannelSplitFilter *channelSplitFilter;
//@property (nonatomic, strong) GPUImagePixellateFilter *channelSplitFilter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GPUImageView *gpuImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = gpuImageView;
    UIImage *inputImage = [UIImage imageNamed:@"face.jpg"];
    _sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage];
    // _channelSplitFilter = [[GPUImagePixellateFilter alloc] init];
    _channelSplitFilter = [[GPUImageChannelSplitFilter alloc] init];
    [_channelSplitFilter setIntensityX:2];
    [_channelSplitFilter setIntensityY:0.2];
    
    [_sourcePicture addTarget: _channelSplitFilter];
    [_channelSplitFilter addTarget:gpuImageView];
    
    [_sourcePicture processImage];
    
}


@end
