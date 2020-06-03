//
//  SK_WebSocketManager.h
//  SK_UIKite
//
//  Created by S&King on 2019/12/30.
//  Copyright © 2019 SKylin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
@interface SK_WebSocketManager : NSObject

@property (nonatomic, strong) SRWebSocket *webSocket;
+ (instancetype)sharedSocketManager;//单例
- (void)connectServer;//建立长连接
- (void)SRWebSocketClose;//关闭长连接
- (void)sendDataToServer:(id)data;//发送数据给服务器
@end
