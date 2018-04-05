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

@interface BusinessOperation :NSOperation

@end

@implementation BusinessOperation

- (void)main{
    if (!self.isCancelled) {
        for (int i = 0; i < 5; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}

@end

typedef void (^Operationtask)(void);

@interface ViewController ()

@property (nonatomic,assign) int ticketCount;

@end

@implementation ViewController
{
    NSLock *_lock;
    NSMutableArray *_ticketsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark 基本操作
    //1、testInvokeOperation
//    [self testInvokeOperation];
    
    //2、testBlockOperation
//    [self testBlockOperation];
    
    //3、testCustomOperation
//    [self testCustomOperation];
    
    //4、testQueue
//    [self testOperationQueue];
    
    //5、addOperationWithBlockToQueue
//    [self addOperationWithBlockToQueue];
    
    //6、test Thread Communication
//    [self testThreadCommunication];
    
    //7、testThreadSafe
    [self testThreadSafe];
    
}

#pragma mark testInvokeOperation
- (void)testInvokeOperation{
    /*运行效果：
    先输出invokeOperationAction，
    然后打印哈哈哈，
    最后进入completionBlock，打印invokeOperationAction did finished
    //阻塞当前主线程，串行、同步执行,不会开启新的线程
    */
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invokeOperationAction) object:nil];
    invocationOperation.completionBlock = ^{
        NSLog(@"invokeOperationAction did finished");
    };
    [invocationOperation start];
    NSLog(@"哈哈哈invocation");
}

- (void)invokeOperationAction{
    NSLog(@"invokeOperationAction did start");
    [NSThread sleepForTimeInterval:2];
}


#pragma mark  ====== Operation ======
#pragma mark testBlockOperation
- (void)testBlockOperation{
    /*运行效果：
     先输出blockOperation did start，
     然后打印哈哈哈block，
     最后进入completionBlock，打印blockOperation did finished
     //阻塞当前主线程，串行、同步执行,不会开启新的线程。
     
     与invocation的区别：
     addExecutionBlock,可以为blockOperation添加额外的操作，这些操作可以在不同的线程中同时并发执行，
     只有当所有的相关操作都已经完成时，才视为完成。如果添加的操作多的话，也可能会在其他的线程中执行
     这由系统决定,经测试，addExecutionBlock的时候，都会开启一个新的线程执行。并且是先执行blockOperationWithBlock里的操作，然后是addExecutionBlock,具体在哪个线程执行无法确定
     */
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation did start on Thread:%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    }];
    
    blockOperation.completionBlock = ^{
        NSLog(@"blockOperation did finished");
    };
    
    //添加额外的操作，开辟新线程，同时并发执行以下的这些操作.
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlockThread:%@",[NSThread currentThread]);
    }];
    
    [blockOperation start];
    NSLog(@"哈哈哈block");
}

#pragma mark test自定义Operation
- (void)testCustomOperation{
    BusinessOperation *customOperation = [[BusinessOperation alloc]init];
    [customOperation start];
}


#pragma mark  ====== Queue ======

#pragma mark
- (void)testOperationQueue{
    /*
     执行结果：开启新线程，进行并发执行，不会阻塞线程
     */
    
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //创建操作
    //操作1:NSInvocationOperation
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(op1) object:nil];
    //操作2：NSInvocationOperation
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(op2) object:nil];
    //操作3：blockOperation
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"op1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1]; // 模拟耗时操作
            NSLog(@"op2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1]; // 模拟耗时操作
            NSLog(@"op3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    //使用addOperation，添加所有操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    NSLog(@"看下是否会阻塞线程");//没有阻塞线程
}


- (void)op1{
    NSLog(@"op1");
}

- (void)op2{
    NSLog(@"op2");
}

- (void)op3{
    NSLog(@"op3");
}

#pragma mark 使用 addOperationWithBlock: 将操作加入到操作队列中||测试线程依赖
- (void)addOperationWithBlockToQueue{
    //创建一个队列，以便向里面添加任务，添加一些block到数组中
    NSMutableArray *blockArr = [NSMutableArray array];
    //创建任务0，栈中的block会被自动拷贝到堆中
    Operationtask task0 = ^(void){
        [NSThread sleepForTimeInterval:1]; // 模拟耗时操作
        NSLog(@"task===0");
    };
    //创建任务1
    Operationtask task1  = ^(void){
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"task===1");

    };
    //创建任务2
    Operationtask task2 = ^(void){
        [NSThread sleepForTimeInterval:3]; // 模拟耗时操作
        NSLog(@"task===2");
    };
  
    //创建void任务
    void(^taskVoid)(void) = ^(void){
        [NSThread sleepForTimeInterval:4]; // 模拟耗时操作
        NSLog(@"task===3");
    };
    
    [blockArr addObjectsFromArray:@[task0,task1,task2,taskVoid]];
    
    NSLog(@"operations:%@",blockArr);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    /*
     maxConcurrentOperationCount:
     为1的时候串行同步执行
     为>1的时候并发异步执行
     
     */
    queue.maxConcurrentOperationCount = 1;
    for (NSUInteger i = 0; i<blockArr.count; i++) {
        Operationtask task = blockArr[i];
        NSBlockOperation *curBlockOperation = [NSBlockOperation blockOperationWithBlock:task];
        if (i<blockArr.count-1) {
            NSBlockOperation *nextBlockOperation = [NSBlockOperation blockOperationWithBlock:blockArr[i+1]];
            //当添加依赖的时候，会在方法调用的时候起到顺序执行的作用，并且会等到之前的操作执行完成后，才会执行接下来的任务，从而达到依赖的作用，在前面的completion代码块中，调用后面的operation，operation完成后，调用completion代码块，不断循环。
            [nextBlockOperation addDependency:curBlockOperation];
        }
        [queue addOperation:curBlockOperation];
    }
}

#pragma mark 线程通讯
- (void)testThreadCommunication{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //子线程与主线程通讯
    [queue addOperationWithBlock:^{
        NSLog(@"thread start operation");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"thread dispatch to main");
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"update mainThread operations");
            self.view.backgroundColor = [UIColor redColor];
        }];
    }];
}

#pragma mark 线程安全,模拟三个窗口同时卖票，多个线程同时更新数据
- (void)testThreadSafe{
    //数据初始化
    _ticketCount = 50;
    _ticketsArray = [NSMutableArray array];
    _lock = [[NSLock alloc]init];
    
    __weak typeof(self)weakSelf = self;
    //创建队列与操作
    
    //创建queue1
    NSOperationQueue *queue1 = [[NSOperationQueue alloc]init];
    //创建任务1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    //创建queue2
    NSOperationQueue *queue2 = [[NSOperationQueue alloc]init];
    
    //创建任务2
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    //创建queue3
    NSOperationQueue *queue3 = [[NSOperationQueue alloc]init];
    //创建任务3
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    [queue1 addOperation:operation1];
    [queue2 addOperation:operation2];
    [queue3 addOperation:operation3];
}


- (void)saleTicketSafe{
    while (1) {
        //加锁
        [_lock lock];//加锁的话会变为同步，变慢，不加锁很快。
        if (self.ticketCount>0) {
            _ticketCount--;
            NSLog(@"剩余票数:%d,窗口：%@",_ticketCount,[NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.2];
        }
        //解锁
        [_lock unlock];
        if (self.ticketCount<=0) {
            NSLog(@"所有火车票已售完");
            break;
        }
    }
}

- (void)writeToDataSourceSafe{
    
}

- (void)deleteDataSourceSafe{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
