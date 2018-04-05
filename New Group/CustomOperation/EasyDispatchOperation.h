//
//  EasyDispatchOperation.h
//  EasyOperation
//
//  Created by ccSunday on 2018/4/5.
//  Copyright © 2018年 ccSunday. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 1、任务与队列
 
 2、封装任务
 
 3、如何控制并发与串行
 
 4、如何切换
 
 5、什么时候需要自定义NSOperation
 
 6、如何设置操作依赖与顺序
 
 7、优先级如何指定
 
 8、线程之间的通讯
 
 9、Operation的其他属性：isExcuting、
 
 10、线程安全与线程同步：如果你的代码所在的进程中有多个线程在同时运行，而这些线程可能会同时运行这段代码，如果每次运行结果和单线程运行的结果是一样的，则称为是线程安全的，
 若每个线程对全局变量、静态变量只有读操作，而没有写操作，一般来说这个全局变量就是线程安全的，若有多个线程同时执行写操作一般需要考虑线程同步，否则的话可能影响线程安全。
 线程同步：A和B线程一起配合，A执行到一定程度时需要依靠线程B的某个结果，于是停下来，示意B运行，B依言而行，再将结果给A。A在继续操作。
 
 基于GCD的封装
 */


/*
 @private
 id _private2;
 void *_reserved2;
 }
 
 + (instancetype)blockOperationWithBlock:(void (^)(void))block;
 
 - (void)addExecutionBlock:(void (^)(void))block;
 @property (readonly, copy) NSArray<void (^)(void)> *executionBlocks;
 
 */

@interface EasyDispatchOperation : NSObject

/**
 设置任务完成时候的代码块
 */
@property (nonatomic, copy) void(^completionBlock)(void);

+ (instancetype)blockOperationWithBlock:(void(^)(void))block;

- (instancetype)initWithTarget:(id)target selector:(SEL)sel object:(id)arg;

- (void)start;

- (void)cancel;

@end
