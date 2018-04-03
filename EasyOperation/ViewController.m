//
//  ViewController.m
//  EasyOperation
//
//  Created by ccSunday on 2018/3/27.
//  Copyright © 2018年 ccSunday. All rights reserved.
//

#import "ViewController.h"
#import "DemoOperationViewController.h"
#import "CustomEasyOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DemoOperationViewController *demoVC = [[DemoOperationViewController alloc]init];
    [self presentViewController:demoVC animated:YES completion:nil];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
