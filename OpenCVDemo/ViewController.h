//
//  ViewController.h
//  OpenCVDemo
//
//  Created by apple on 14-4-8.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <UIKit/UIKit.h>


using namespace std;
using namespace cv;

BOOL try_use_gpu = false;
vector<Mat> imgs;
string result_name = "result.jpg";

@interface ViewController : UIViewController
{
    
}

@end
