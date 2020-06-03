//
//  ViewController.m
//  GPUImageMosaicFilter
//
//  Created by yuhua.cheng on 2020/6/3.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
#import "GPUImageSquareMosaicFilter.h"
#import "GPUImageCircleMosaicFilter.h"

@interface ViewController ()
@property (nonatomic, strong) GPUImagePicture *sourceImage;
//@property (nonatomic, strong) GPUImageMosaicFilter *mosaicFilter;
//@property (nonatomic, strong) GPUImageSquareMosaicFilter *mosaicFilter;
@property (nonatomic, strong) GPUImageCircleMosaicFilter *mosaicFilter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GPUImageView *gpuImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = gpuImageView;
    UIImage *image = [UIImage imageNamed:@"face.jpg"];
    _sourceImage = [[GPUImagePicture alloc] initWithImage:image];
    
    //_mosaicFilter = [[GPUImageMosaicFilter alloc] init];
    //[_mosaicFilter setTileSet:@"squares.png"];
    //[_mosaicFilter setColorOn:YES];
    
//    _mosaicFilter = [[GPUImageSquareMosaicFilter alloc] init];
//    [_mosaicFilter setImageHeightFactor:0.03];
//    [_mosaicFilter setImageWdithFactor:0.03];

    _mosaicFilter = [[GPUImageCircleMosaicFilter alloc] init];
    [_mosaicFilter setMosaicSize:20];
    [_mosaicFilter setImageWidth:image.size.width];
    [_mosaicFilter setImageHeight:image.size.height];
    
    [_sourceImage addTarget:_mosaicFilter];
    [_mosaicFilter addTarget:gpuImageView];
    [_sourceImage processImage];
}


@end
