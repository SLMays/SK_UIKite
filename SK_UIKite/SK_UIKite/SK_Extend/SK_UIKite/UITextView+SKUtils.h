//
//  UITextView+SKUtils.h
//  SK_UIKite
//
//  Created by Skylin on 2018/4/25.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^textViewHeightDidChangedBlock)(CGFloat currentTextViewHeight);

@interface UITextView (SKUtils)

/* 占位文字 */
@property (nonatomic, copy) NSString *sk_placeholder;


/* 占位文字颜色 */
@property (nonatomic, strong) UIColor *sk_placeholderColor;


/* 最大高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat sk_maxHeight;


/* 最小高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat sk_minHeight;


@property (nonatomic, copy) textViewHeightDidChangedBlock sk_textViewHeightDidChanged;


/* 获取图片数组 */
- (NSArray *)sk_getImages;


/* 自动高度的方法，maxHeight：最大高度 */
- (void)sk_autoHeightWithMaxHeight:(CGFloat)maxHeight;


/* 自动高度的方法，maxHeight：最大高度， textHeightDidChanged：高度改变的时候调用 */
- (void)sk_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(textViewHeightDidChangedBlock)textViewHeightDidChanged;

/* 添加一张图片 image:要添加的图片 */
- (void)sk_addImage:(UIImage *)image;


/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)sk_addImage:(UIImage *)image size:(CGSize)size;


/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)sk_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index;


/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)sk_addImage:(UIImage *)image multiple:(CGFloat)multiple;


/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)sk_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index;


@end
