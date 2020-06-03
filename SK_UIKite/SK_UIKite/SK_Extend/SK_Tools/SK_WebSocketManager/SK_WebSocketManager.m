//
//  SK_WebSocketManager.m
//  SK_UIKite
//
//  Created by S&King on 2019/12/30.
//  Copyright © 2019 SKylin. All rights reserved.
//

//主线程异步队列
#define sk_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#import "SK_WebSocketManager.h"

@interface SK_WebSocketManager()<SRWebSocketDelegate>

@property (nonatomic, strong) NSTimer *heartBeatTimer; //心跳定时器
@property (nonatomic, strong) NSTimer *netWorkTestingTimer; //没有网络的时候检测网络定时器
@property (nonatomic, strong) dispatch_queue_t queue; //数据请求队列（串行队列）
@property (nonatomic, assign) NSTimeInterval reConnectTime; //重连时间
@property (nonatomic, strong) NSMutableArray *sendDataArray; //存储要发送给服务端的数据
@property (nonatomic, assign) BOOL isActivelyClose;    //用于判断是否主动关闭长连接，如果是主动断开连接，连接失败的代理中，就不用执行 重新连接方法

@end

@implementation SK_WebSocketManager

//单例
+ (instancetype)sharedSocketManager
{
    static SK_WebSocketManager *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.reConnectTime = 0;
        self.isActivelyClose = NO;
        self.queue = dispatch_queue_create("BF",NULL);
        self.sendDataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - NSTimer

//初始化心跳
- (void)initHeartBeat
{
    //心跳没有被关闭
    if(self.heartBeatTimer)
    {
        return;
    }
    
    [self destoryHeartBeat];
    
    SK_WEAKSELF
    sk_dispatch_main_async_safe(^{
        _weakSelf.heartBeatTimer  = [NSTimer timerWithTimeInterval:10 target:_weakSelf selector:@selector(senderheartBeat) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop]addTimer:_weakSelf.heartBeatTimer forMode:NSRunLoopCommonModes];
    });
}

//取消心跳
- (void)destoryHeartBeat
{
    SK_WEAKSELF
    sk_dispatch_main_async_safe(^{
        if(_weakSelf.heartBeatTimer)
        {
            [_weakSelf.heartBeatTimer invalidate];
            _weakSelf.heartBeatTimer = nil;
        }
    });
}

//没有网络的时候开始定时 -- 用于网络检测
- (void)noNetWorkStartTestingTimer
{
    SK_WEAKSELF
    sk_dispatch_main_async_safe(^{
        _weakSelf.netWorkTestingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:_weakSelf selector:@selector(noNetWorkStartTesting) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_weakSelf.netWorkTestingTimer forMode:NSDefaultRunLoopMode];
    });
}

//取消网络检测
- (void)destoryNetWorkStartTesting
{
    SK_WEAKSELF
    sk_dispatch_main_async_safe(^{
        if(_weakSelf.netWorkTestingTimer)
        {
            [_weakSelf.netWorkTestingTimer invalidate];
            _weakSelf.netWorkTestingTimer = nil;
        }
    });
}

#pragma mark - private -- webSocket相关方法

//发送心跳
- (void)senderheartBeat
{
    //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
    SK_WEAKSELF
    sk_dispatch_main_async_safe(^{
        if(_weakSelf.webSocket.readyState == SR_OPEN)
        {
            [_weakSelf.webSocket sendPing:nil];
        }
    });
}
//Say Hi
-(void)SayHi
{
    NSDictionary * dic = @{@"hi":@{@"id":@"123456789",
                                   @"ver":@"0.16.3-rc3",
                                   @"ua":@"useragent",
                                   @"lang":@"zh-CN"}
                           
    };
    NSString * data = [NSString GetJsonStrWithDictionary:dic];
    
    [[SK_WebSocketManager sharedSocketManager] sendDataToServer:data];
}
//定时检测网络
- (void)noNetWorkStartTesting
{
    //有网络
    if(AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable)
    {
        //关闭网络检测定时器
        [self destoryNetWorkStartTesting];
        //开始重连
        [self reConnectServer];
    }
}

//建立长连接
- (void)connectServer
{
    self.isActivelyClose = NO;
    
    if(self.webSocket)
    {
        self.webSocket = nil;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://210.22.105.6:6060/v0/channels?apikey=AQEAAAABAAD_rAp4DJh05a1HAwFT3A6K"]];
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

//重新连接服务器
- (void)reConnectServer
{
    if(self.webSocket.readyState == SR_OPEN)
    {
        return;
    }
    
    if(self.reConnectTime > 1024)  //重连10次 2^10 = 1024
    {
        self.reConnectTime = 0;
        return;
    }
    
    SK_WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.reConnectTime *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(_weakSelf.webSocket.readyState == SR_OPEN && _weakSelf.webSocket.readyState == SR_CONNECTING)
        {
            return;
        }
        
        [_weakSelf connectServer];
        NSLog(@"正在重连......");
        
        if(_weakSelf.reConnectTime == 0)  //重连时间2的指数级增长
        {
            _weakSelf.reConnectTime = 2;
        }
        else
        {
            _weakSelf.reConnectTime *= 2;
        }
    });
    
}

//关闭连接
- (void)SRWebSocketClose;
{
    self.isActivelyClose = YES;
    [self webSocketClose];
    
    //关闭心跳定时器
    [self destoryHeartBeat];
    
    //关闭网络检测定时器
    [self destoryNetWorkStartTesting];
}

//关闭连接
- (void)webSocketClose
{
    if(self.webSocket)
    {
        [self.webSocket close];
        self.webSocket = nil;
    }
}

//发送数据给服务器
- (void)sendDataToServer:(id)data
{
    [self.sendDataArray addObject:data];
    [self sendeDataToServer];
}


- (void)sendeDataToServer
{
    SK_WEAKSELF
    
    //把数据放到一个请求队列中
    dispatch_async(self.queue, ^{
        
        //没有网络
        if (AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
        {
            //开启网络检测定时器
            [_weakSelf noNetWorkStartTestingTimer];
        }
        else //有网络
        {
            if(_weakSelf.webSocket != nil)
            {
                // 只有长连接OPEN开启状态才能调 send 方法，不然会Crash
                if(_weakSelf.webSocket.readyState == SR_OPEN)
                {
                    if (_weakSelf.sendDataArray.count > 0)
                    {
                        NSString *data = _weakSelf.sendDataArray[0];
                        [_weakSelf.webSocket send:data]; //发送数据
                        [_weakSelf.sendDataArray removeObjectAtIndex:0];
       
                        if([_weakSelf.sendDataArray count] > 0)
                        {
                            [_weakSelf sendeDataToServer];
                        }
                    }
                }
                else if (_weakSelf.webSocket.readyState == SR_CONNECTING) //正在连接
                {
                    NSLog(@"正在连接中，重连后会去自动同步数据");
                }
                else if (_weakSelf.webSocket.readyState == SR_CLOSING || _weakSelf.webSocket.readyState == SR_CLOSED) //断开连接
                {
                    //调用 reConnectServer 方法重连,连接成功后 继续发送数据
                    [_weakSelf reConnectServer];
                }
            }
            else
            {
                [_weakSelf connectServer]; //连接服务器
            }
        }
    });
}

#pragma mark - SRWebSocketDelegate -- webSockect代理

//连接成功回调
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"webSocket ===  连接成功");
    
    [self initHeartBeat]; //开启心跳
    
    [self SayHi]; //sayHi
    
    //如果有尚未发送的数据，继续向服务端发送数据
    if ([self.sendDataArray count] > 0){
        [self sendeDataToServer];
    }
}

//连接失败回调
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    //用户主动断开连接，就不去进行重连
    if(self.isActivelyClose)
    {
        return;
    }
    
    [self destoryHeartBeat]; //断开连接时销毁心跳
    
    NSLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@"3.连接次数限制，如果连接失败了，重试10次左右就可以了");
    
    //判断网络环境
    if (AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) //没有网络
    {
        [self noNetWorkStartTestingTimer];//开启网络检测定时器
    }
    else //有网络
    {
        [self reConnectServer];//连接失败就重连
    }
}

//连接关闭,注意连接关闭不是连接断开，关闭是 [socket close] 客户端主动关闭，断开可能是断网了，被动断开的。
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    // 在这里判断 webSocket 的状态 是否为 open , 大家估计会有些奇怪 ，因为我们的服务器都在海外，会有些时间差，经过测试，我们在进行某次连接的时候，上次重连的回调刚好回来，而本次重连又成功了，就会误以为，本次没有重连成功，而再次进行重连，就会出现问题，所以在这里做了一下判断
    if(self.webSocket.readyState == SR_OPEN || self.isActivelyClose)
    {
        return;
    }
    
    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);
    
    [self destoryHeartBeat]; //断开连接时销毁心跳
    
    //判断网络环境
    if (AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) //没有网络
    {
        [self noNetWorkStartTestingTimer];//开启网络检测
    }
    else //有网络
    {
        [self reConnectServer];//连接失败就重连
    }
}

//该函数是接收服务器发送的pong消息，其中最后一个参数是接受pong消息的
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData*)pongPayload
{
    NSString* reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply === 收到后台心跳回复 Data:%@",reply);
}

//收到服务器发来的数据
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSDictionary *dataDic = [NSDictionary GetDictionaryWithString:message];
    /*根据具体的业务做具体的处理*/
    NSLog(@"收到服务器发来的数据：%@",dataDic);

}

@end
