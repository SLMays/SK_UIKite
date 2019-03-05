//
//  SK_GCDTimer.h
//  GuJia_MMZQ
//
//  Created by Skylin on 2018/7/5.
//  Copyright © 2018年 美美证券. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SK_GCDTimer : NSObject

void dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer));

@end
