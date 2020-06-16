//
//  ViewController.m
//  GPUImageExperimentalDemo
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
#import "GPUImageExperimentalFilter.h"

@interface ViewController ()
@property GPUImageFilter *filter;
@property GPUImageView *gpuImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"face.jpg"];
    _gpuImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = _gpuImageView;
    _filter = [[GPUImageExperimentalFilter alloc] init];
    [(GPUImageExperimentalFilter *)_filter setScale: 0.2];
    
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image];
    [picture addTarget:_filter];
    [_filter addTarget:_gpuImageView];
    [picture processImage];
}


@end
