//
//  ViewController.m
//  OpenCVDemo
//
//  Created by apple on 14-4-8.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "ViewController.h"
#import "opencv2/highgui/highgui.hpp"
#import <opencv2/stitching/stitcher.hpp>

@interface ViewController ()
{
    Mat pano;
    IplImage *img;
    UIImage *imageIOS;
    UIAlertView * alert;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    alert = [[UIAlertView alloc] initWithTitle:nil message:@"success" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"jpg"];
    NSLog(@"%@",path);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)printUsage
{
    
    Mat image1 = imread("/Users/taagoomacmini/Library/Application Support/iPhone Simulator/7.1/Applications/069B514E-618B-4091-97D5-A20306F4C793/OpenCVDemo.app/1.jpg");
    imgs.push_back(image1);
    Mat image2 = imread("/Users/taagoomacmini/Library/Application Support/iPhone Simulator/7.1/Applications/069B514E-618B-4091-97D5-A20306F4C793/OpenCVDemo.app/2.jpg");
    imgs.push_back(image2);
    Mat image3 = imread("/Users/taagoomacmini/Library/Application Support/iPhone Simulator/7.1/Applications/069B514E-618B-4091-97D5-A20306F4C793/OpenCVDemo.app/3.jpg");
    imgs.push_back(image3);
    
    
    Stitcher stitcher = Stitcher::createDefault(try_use_gpu);
    Stitcher::Status status = stitcher.stitch(imgs, pano);
    
    if (status != Stitcher::OK)
    {
        NSLog(@"Can't stitch images, error code = %d",status);
    } else {
        [alert show];
    }
    
    imwrite(result_name, pano);
    
    pano.clone();
    img = cvCreateImage(cvSize (pano.cols,pano.rows), 8, 3);
    img->imageData = (char *)pano.data;
    
}

//- (UIImage *)UIImageFromIplImage:(IplImage *)image {
//    
//    NSLog(@"IplImage (%d, %d) %d bits by %d channels, %d bytes/row %s", image->width, image->height, image->depth, image->nChannels, image->widthStep, image->channelSeq);
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    NSData *data = [NSData dataWithBytes:image->imageData length:image->imageSize];
//    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
//    // Creating CGImage from chunk of IplImage
//    CGImageRef imageRef = CGImageCreate(image->width, image->height,image->depth, image->depth * image->nChannels, image->widthStep,colorSpace, kCGImageAlphaNone|kCGBitmapByteOrderDefault,provider, NULL, false, kCGRenderingIntentDefault);
//    // Getting UIImage from CGImage
//    UIImage *ret = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//    CGDataProviderRelease(provider);
//    CGColorSpaceRelease(colorSpace);
//    return ret;
//}


- (UIImage *)UIImageFromIplImage:(IplImage *)image {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // Allocating the buffer for CGImage
    NSData *data = [NSData dataWithBytes:image->imageData length:image->imageSize];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    // Creating CGImage from chunk of IplImage
    CGImageRef imageRef = CGImageCreate(image->width, image->height,image->depth, image->depth * image->nChannels, image->widthStep,colorSpace, kCGImageAlphaNone|kCGBitmapByteOrderDefault,provider, NULL, false, kCGRenderingIntentDefault);
    // Getting UIImage from CGImage
    UIImage *ret = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    return ret;
}

- (IBAction)action:(id)sender {
    [self printUsage];
}

- (IBAction)show:(id)sender {
    imageIOS = [self UIImageFromIplImage:self->img];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320*5, 568)];
    imageView.image = imageIOS;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
    scrollView.contentSize = CGSizeMake(320*5, 600);
    [scrollView addSubview:imageView];
    //scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
}




@end
