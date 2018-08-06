//
//  FixOrientation.h
//  YGTYFUER
//
//  Created by dragon on 15/5/22.
//  Copyright (c) 2015年 dragon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixOrientation : NSObject

@end


@interface UIImage (fixOrientation)

/**
 *  调整图像方向上传服务器  针对Android显示方向错位
 *
 *  @return 调整后的图片
 */
- (UIImage *)fixOrientation;

/**
 *  调整图片显示方向  始终使图片横向摆放
 */
- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

@end

