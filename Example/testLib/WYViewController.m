//
//  WYViewController.m
//  testLib
//
//  Created by fangwenyu on 11/29/2016.
//  Copyright (c) 2016 fangwenyu. All rights reserved.
//

#import "WYViewController.h"
#import "WY_WaterFallFlowLayout.h"

@interface WYViewController ()

@end

@implementation WYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    WY_WaterFallFlowLayout *layout = [[WY_WaterFallFlowLayout alloc]init];
    NSLog(@"%@", layout);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
