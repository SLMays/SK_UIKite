//
//  UIWindow+SKUtils.m
//  SK_UIKite
//
//  Created by Skylin on 2018/8/3.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "UIWindow+SKUtils.h"

@implementation UIWindow (SKUtils)

- (UIImage *)sk_screenshot
{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);//数值 0 - 1 之间
    image = [UIImage imageWithData:imageData];
    return image;
}

@end
