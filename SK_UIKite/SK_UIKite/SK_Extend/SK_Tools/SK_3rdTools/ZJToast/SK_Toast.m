//
//  SK_Toast.m
//  SK_Toast
//
//  Created by Choi on 2017/4/9.
//  Copyright © 2017年 CSK_. All rights reserved.
//

#import "SK_Toast.h"

// display duration and position
static const CGFloat SK_ToastDefaultDuration    = 3.5;
static const NSString *SK_ToastDefaultPosition  = @"bottom";

// general appearance
static const CGFloat SK_ToastHorizontalMargin   = 10.0;
static const CGFloat SK_ToastVerticalMargin     = 10.0;
static const CGFloat SK_ToastCornerRadius       = 10.0;
static const CGFloat SK_ToastFontSize           = 16.0;

// shadow appearance
static const CGFloat SK_ToastShadowOpacity       = 0.7;
static const CGFloat SK_ToastShadowRadius        = 4.0;
static const CGSize  SK_ToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    SK_ToastDisplayShadow       = YES;

@interface SK_Toast ()

@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation SK_Toast

#pragma mark - 创建单例
+ (SK_Toast *)sharedInstance
{
    static SK_Toast *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SK_Toast alloc] init];
        
    });
    return sharedManager;
}

#pragma mark - toast 信息
- (void)makeToast:(NSString *)message
{
    [self makeToast:message duration:SK_ToastDefaultDuration position:SK_ToastDefaultPosition];
}
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position {
    [self viewForMessage:message title:nil image:nil];
    [self showToast:self duration:interval position:position];
}

#pragma mark - init 创建toast
- (instancetype)init
{
    if (self = [super init]) {
        [self createMessageAndTitleAndImage];
    }
    return self;
}
- (void)createMessageAndTitleAndImage
{
    self.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    self.userInteractionEnabled = NO;
    self.layer.cornerRadius = SK_ToastCornerRadius;
    
    if (SK_ToastDisplayShadow) {
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = SK_ToastShadowOpacity;
        self.layer.shadowRadius = SK_ToastShadowRadius;
        self.layer.shadowOffset = SK_ToastShadowOffset;
    }
    // color
    self.backgroundColor = COLORWITHRGBA(0, 0, 0, 0.5);
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.font = [UIFont systemFontOfSize:SK_ToastFontSize];
    messageLabel.numberOfLines = 0;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.textColor = [UIColor whiteColor];
    _messageLabel = messageLabel;
    [self addSubview:_messageLabel];
}

- (void)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image
{
    if((message == nil) && (title == nil) && (image == nil)) return;
    
    CGRect frame = CGRectMake(0, 0, 0, 0);
    if (message != nil) {
        message = [NSString stringWithFormat:@"%@",message];
        _messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake(WIDTH_IPHONE - SK_ToastHorizontalMargin*2, HEIGHT_IPHONE - SK_ToastVerticalMargin*2);
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:SK_ToastFontSize]};
        CGRect expectedSizeMessage = [message boundingRectWithSize:maxSizeMessage options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        frame = expectedSizeMessage;
        frame.origin.x = SK_ToastHorizontalMargin;
        frame.origin.y = SK_ToastVerticalMargin;
        _messageLabel.frame = frame;
    } else {
        _messageLabel.frame = frame;
    }
    
    self.frame = CGRectMake(0, 0, frame.size.width + frame.origin.x*2, frame.size.height + frame.origin.y*2);
    
}
- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point
{
    [self removeFromSuperview];
    toast.center = [self centerPointForPosition:point withToast:toast];
    toast.alpha = 0.0;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window.subviews.lastObject addSubview:self];
//    [window.subviews.lastObject bringSubviewToFront:self];
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.25
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              toast.alpha = 0.0;
                                          } completion:nil];
                     }];
    
}

- (CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast
{
    if([point isKindOfClass:[NSString class]]) {
        // convert string literals @"top", @"bottom", @"center", or any point wrapped in an NSValue object into a CGPoint
        CGFloat centerX = WIDTH_IPHONE/2;
        CGFloat centerY = HEIGHT_IPHONE/2;
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(centerX, (toast.frame.size.height/2) + Height_StatusBar);
        } else if([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame) {
            return CGPointMake(centerX, HAVE_TABBAR_HEIGHT-toast.height/2);
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            return CGPointMake(centerX, centerY);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    return [self centerPointForPosition:SK_ToastDefaultPosition withToast:toast];
}

@end
