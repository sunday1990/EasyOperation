//
//  DemoOperationViewController.m
//  EasyOperation
//
//  Created by ccSunday on 2018/3/27.
//  Copyright © 2018年 ccSunday. All rights reserved.
//

#import "DemoOperationViewController.h"
#import "CustomEasyOperation.h"

@interface DemoOperationViewController ()

@end

@implementation DemoOperationViewController
#pragma mark ======== Life Cycle ========
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additioxnal setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    //情况一：
//    [CustomEasyOperation operationWithCallBack:^(id obj) {
//       NSLog(@"self:%@ \n obj:%@",self,obj);//这时候不会提示循环引用,但是会造成循环引用
//    }];
    
    //情况二：
//    __weak typeof(self) weakSlf = self;
//    [CustomEasyOperation operationWithNORetunCallBack:^(id obj) {
//        __strong typeof (weakSlf)strongSlf = weakSlf;
//        NSLog(@"self:%@ \n obj:%@",strongSlf,obj);//声明为weak后，这时候不会提示循环引用
//    }];
    
    //情况三：
    [CustomEasyOperation operationWithCycleAutoBeNilCallBack:^void(id obj) {
        NSLog(@"finish");

    }];
    
    
    //情况四
//    [CustomEasyOperation operationWithReturnValueCycleAutoBeNilCallBack:^NSString *(id obj) {
//       //执行一个相对耗时的操作后，再返回一个值，
//    }];
}

- (void)testBtnClick:(UIButton *)btn{
//    [CustomEasyOperation operationWithCycleAutoBeNilCallBack:^(id obj) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [NSThread sleepForTimeInterval:5];
//            NSLog(@"self:%@ \n obj:%@",self,obj);//声明为weak后，这时候不会提示循环引用
//
//
//        });
//        NSLog(@"finish");
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ======== NetWork ========

#pragma mark ======== System Delegate ========

#pragma mark ======== Custom Delegate ========

#pragma mark ======== Notifications && Observers ========

#pragma mark ======== Event Response ========

#pragma mark ======== Private Methods ========
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ======== Setters && Getters ========
- (void)dealloc{
    NSLog(@"dealloc");
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


