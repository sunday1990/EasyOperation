//
//  EasyDispatchOperation.m
//  EasyOperation
//
//  Created by ccSunday on 2018/4/5.
//  Copyright © 2018年 ccSunday. All rights reserved.
//

#import "EasyDispatchOperation.h"

@interface EasyDispatchOperation ()

@property dispatch_queue_t queue;


@end

@implementation EasyDispatchOperation{
    id _private;
    void *_reserved;
}


+ (instancetype)blockOperationWithBlock:(void(^)(void))block{//需要声明一个指针指向这个block，待到start
    return [[self alloc]initWithBlock:block];
}

- (instancetype)initWithTarget:(id)target selector:(SEL)sel object:(id)arg{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithBlockOperation:(void(^)(void))block{
    self = [super init];
    if (self) {
        _reserved = (__bridge void *)(block);
    }
    return self;
}

- (void)start{
    //获取当前线程，并在当前线程下同步执行一些操作，待到操作结束后，执行completion代码块
    
    
    
}

- (void)cancel{
    //
}

- (void)setCompletionBlock:(void (^)(void))completionBlock{
    _completionBlock = completionBlock;
}

@end
