//
//  SK_GCDTimer.m
//  WEX
//
//  Created by Skylin on 2018/7/5.
//  Copyright © 2018年 WEX. All rights reserved.
//

#import "SK_GCDTimer.h"

@interface SK_GCDTimer()
@property (nonatomic, strong) NSMutableDictionary *timerContainer;
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation SK_GCDTimer

#pragma mark - Public Method

+ (SK_GCDTimer *)sharedInstance {
    static SK_GCDTimer *_gcdTimerManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        _gcdTimerManager = [[SK_GCDTimer alloc] init];
    });
    
    return _gcdTimerManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_USER_INITIATED, 0);
        dispatch_queue_t queue = dispatch_queue_create("com.JX_GCDTimerManager.queue", attr);
        _queue = queue;
        _timerContainer = [NSMutableDictionary new];
    }
    return self;
}

- (void)startDispatchTimerWithName:(NSString *)timerName
                      timeInterval:(double)interval
                             queue:(dispatch_queue_t)queue
                           repeats:(BOOL)repeats
                     fireInstantly:(BOOL)fireInstantly
                            action:(dispatch_block_t)dispatchBlock {
    if (!timerName || timerName.length == 0 || !dispatchBlock) return;
    
    if (nil == queue)
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_barrier_async(self.queue, ^{
        dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
        if (!timer) {
            timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            [self.timerContainer setObject:timer forKey:timerName];
            dispatch_resume(timer);
        }
        
        if (repeats && fireInstantly) {
            dispatch_async(queue, dispatchBlock);
        }
        
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.01 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if (!repeats) {
                [self.timerContainer removeObjectForKey:timerName];
                dispatch_source_cancel(timer);
            }
            
            dispatchBlock();
        });
    });
}

- (void)cancelTimerWithName:(NSString *)timerName {
    dispatch_barrier_async(self.queue, ^{
        dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
        
        if (!timer) {
            return;
        }
        
        [self.timerContainer removeObjectForKey:timerName];
        dispatch_source_cancel(timer);
    });
}

- (void)checkExistTimer:(NSString *)timerName completion:(void (^)(BOOL))completion {
    dispatch_async(self.queue, ^{
        if ([self.timerContainer objectForKey:timerName]) {
            completion(YES);
        } else {
            completion(NO);
        }
    });
}

@end
