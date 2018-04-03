//
//  CustomEasyOperation.m
//  EasyOperation
//
//  Created by ccSunday on 2018/3/27.
//  Copyright © 2018年 ccSunday. All rights reserved.
//

#import "CustomEasyOperation.h"

typedef void (^TestCallBack)(id obj);

typedef NSString *(^TestReturnCallBack)(id obj);

TestCallBack _callBack;
TestReturnCallBack _returnCallBack;

@implementation CustomEasyOperation

+ (void)operationWithNORetunCallBack:(void(^)(id obj))callBack{
    _callBack = callBack;
    if (_callBack) {
        _callBack(@1);
    }
}

/**
1、如果block中执行同步任务：block会等到执行完后才会置为nil。如果没有执行完失败了，那么block也要置为nil才可以，不然的话会造成循环应用
 
2、如果block中执行异步任务:block目前不会等任务执行完才置为nil，而是会立马置为nil，这样如果外界要回传值得话，可能会造成崩溃

 */
+ (void)operationWithCycleAutoBeNilCallBack:(void(^)(id obj))callBack{
    
    
    //1、添加到NSOperationQueue中
    if (!_callBack) {
        _callBack = callBack;
    }
    
//    if (callBack) {
//        callBack(@1);
//    }
//    _callBack = nil;
//    NSLog(@"callBack");
//    return;
    
    //2、添加到dispatch_queue中
    dispatch_group_t group = dispatch_group_create();
    //不能异步调用
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        if (callBack) {
            callBack(@1);
        }
    });
    //
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        _callBack = nil;
        NSLog(@"block = nil");
    });
    //如果这样写的话，block调用后，紧接着就释放了，如果外面需要给block返回值，那么就会崩溃
    
}

#pragma mark 带返回值的block，自动置为nil
+ (void)operationWithReturnValueCycleAutoBeNilCallBack:(NSString*(^)(id obj))callBack{
    
}


+ (instancetype)operationWithCallBack:(void(^)(id obj))callBack{
    return [[self alloc]initWithOperationWithCallBack:callBack];
}


- (instancetype)initWithOperationWithCallBack:(void(^)(id obj))callBack{
    if (self = [super init]) {
        _callBack = callBack;
        if (_callBack) {
            _callBack(@1);
        }

    }
    return self;
}
@end
