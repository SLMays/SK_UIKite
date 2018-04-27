//
//  UITextView+SKUtils.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/25.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "UITextView+SKUtils.h"
#import <objc/runtime.h>

// 占位文字
static const void *SKPlaceholderViewKey = &SKPlaceholderViewKey;
// 占位文字颜色
static const void *SKPlaceholderColorKey = &SKPlaceholderColorKey;
// 最大高度
static const void *SKTextViewMaxHeightKey = &SKTextViewMaxHeightKey;
// 最小高度
static const void *SKTextViewMinHeightKey = &SKTextViewMinHeightKey;
// 高度变化的block
static const void *SKTextViewHeightDidChangedBlockKey = &SKTextViewHeightDidChangedBlockKey;
// 存储添加的图片
static const void *SKTextViewImageArrayKey = &SKTextViewImageArrayKey;
// 存储最后一次改变高度后的值
static const void *SKTextViewLastHeightKey = &SKTextViewLastHeightKey;


@interface UITextView ()
// 存储添加的图片
@property (nonatomic, strong) NSMutableArray *sk_imageArray;
// 存储最后一次改变高度后的值
@property (nonatomic, assign) CGFloat lastHeight;

@end

@implementation UITextView (SKUtils)
@dynamic sk_placeholder;
@dynamic sk_placeholderColor;
@dynamic sk_maxHeight;
@dynamic sk_minHeight;
@dynamic sk_textViewHeightDidChanged;


#pragma mark - Swizzle Dealloc
+ (void)load {
    // 交换dealoc
    Method dealoc = class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc"));
    Method myDealloc = class_getInstanceMethod(self.class, @selector(myDealloc));
    method_exchangeImplementations(dealoc, myDealloc);
}

- (void)myDealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    UITextView *placeholderView = objc_getAssociatedObject(self, SKPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        for (NSString *property in propertys) {
            @try {
                [self removeObserver:self forKeyPath:property];
            } @catch (NSException *exception) {}
        }
    }
    [self myDealloc];
}

#pragma mark - set && get
- (UITextView *)sk_placeholderView {
    
    // 为了让占位文字和textView的实际文字位置能够完全一致，这里用UITextView
    UITextView *placeholderView = objc_getAssociatedObject(self, SKPlaceholderViewKey);
    
    if (!placeholderView) {
        
        // 初始化数组
        self.sk_imageArray = [NSMutableArray array];
        
        placeholderView = [[UITextView alloc] init];
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, SKPlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        placeholderView = placeholderView;
        
        // 设置基本属性
        placeholderView.scrollEnabled = placeholderView.userInteractionEnabled = NO;
        //        self.scrollEnabled = placeholderView.scrollEnabled = placeholderView.showsHorizontalScrollIndicator = placeholderView.showsVerticalScrollIndicator = placeholderView.userInteractionEnabled = NO;
        placeholderView.textColor = [UIColor lightGrayColor];
        placeholderView.backgroundColor = [UIColor clearColor];
        [self refreshPlaceholderView];
        [self addSubview:placeholderView];
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange) name:UITextViewTextDidChangeNotification object:self];
        
        // 这些属性改变时，都要作出一定的改变，尽管已经监听了TextDidChange的通知，也要监听text属性，因为通知监听不到setText：
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        
        // 监听属性
        for (NSString *property in propertys) {
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
        }
        
    }
    return placeholderView;
}

- (void)setsk_placeholder:(NSString *)placeholder
{
    // 为placeholder赋值
    [self sk_placeholderView].text = placeholder;
}

- (NSString *)sk_placeholder
{
    // 如果有placeholder值才去调用，这步很重要
    if (self.placeholderExist) {
        return [self sk_placeholderView].text;
    }
    return nil;
}

- (void)setsk_placeholderColor:(UIColor *)sk_placeholderColor
{
    // 如果有placeholder值才去调用，这步很重要
    if (!self.placeholderExist) {
        NSLog(@"请先设置placeholder值！");
    } else {
        self.sk_placeholderView.textColor = sk_placeholderColor;
        
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, SKPlaceholderColorKey, sk_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)sk_placeholderColor
{
    return objc_getAssociatedObject(self, SKPlaceholderColorKey);
}

- (void)setsk_maxHeight:(CGFloat)sk_maxHeight
{
    CGFloat max = sk_maxHeight;
    
    // 如果传入的最大高度小于textView本身的高度，则让最大高度等于本身高度
    if (sk_maxHeight < self.frame.size.height) {
        max = self.frame.size.height;
    }
    
    objc_setAssociatedObject(self, SKTextViewMaxHeightKey, [NSString stringWithFormat:@"%lf", max], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)sk_maxHeight
{
    return [objc_getAssociatedObject(self, SKTextViewMaxHeightKey) doubleValue];
}

- (void)setsk_minHeight:(CGFloat)sk_minHeight
{
    objc_setAssociatedObject(self, SKTextViewMinHeightKey, [NSString stringWithFormat:@"%lf", sk_minHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)sk_minHeight
{
    return [objc_getAssociatedObject(self, SKTextViewMinHeightKey) doubleValue];
}

- (void)setsk_textViewHeightDidChanged:(textViewHeightDidChangedBlock)sk_textViewHeightDidChanged
{
    objc_setAssociatedObject(self, SKTextViewHeightDidChangedBlockKey, sk_textViewHeightDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (textViewHeightDidChangedBlock)sk_textViewHeightDidChanged
{
    void(^textViewHeightDidChanged)(CGFloat currentHeight) = objc_getAssociatedObject(self, SKTextViewHeightDidChangedBlockKey);
    return textViewHeightDidChanged;
}

- (NSArray *)sk_getImages
{
    return self.sk_imageArray;
}

- (void)setLastHeight:(CGFloat)lastHeight {
    objc_setAssociatedObject(self, SKTextViewLastHeightKey, [NSString stringWithFormat:@"%lf", lastHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)lastHeight {
    return [objc_getAssociatedObject(self, SKTextViewLastHeightKey) doubleValue];
}

- (void)setsk_imageArray:(NSMutableArray *)sk_imageArray {
    objc_setAssociatedObject(self, SKTextViewImageArrayKey, sk_imageArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)sk_imageArray {
    return objc_getAssociatedObject(self, SKTextViewImageArrayKey);
}

- (void)sk_autoHeightWithMaxHeight:(CGFloat)maxHeight
{
    [self sk_autoHeightWithMaxHeight:maxHeight textViewHeightDidChanged:nil];
}
// 是否启用自动高度，默认为NO
static bool autoHeight = NO;
- (void)sk_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(textViewHeightDidChangedBlock)textViewHeightDidChanged
{
    autoHeight = YES;
    [self sk_placeholderView];
    self.sk_maxHeight = maxHeight;
    if (textViewHeightDidChanged) self.sk_textViewHeightDidChanged = textViewHeightDidChanged;
}

#pragma mark - addImage
/* 添加一张图片 */
- (void)sk_addImage:(UIImage *)image
{
    [self sk_addImage:image size:CGSizeZero];
}

/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)sk_addImage:(UIImage *)image size:(CGSize)size
{
    [self sk_insertImage:image size:size index:self.attributedText.length > 0 ? self.attributedText.length : 0];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)sk_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index
{
    [self sk_addImage:image size:size index:index multiple:-1];
}

/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)sk_addImage:(UIImage *)image multiple:(CGFloat)multiple
{
    [self sk_addImage:image size:CGSizeZero index:self.attributedText.length > 0 ? self.attributedText.length : 0 multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)sk_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index
{
    [self sk_addImage:image size:CGSizeZero index:index multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 multiple:放大／缩小的倍数 */
- (void)sk_addImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index multiple:(CGFloat)multiple {
    if (image) [self.sk_imageArray addObject:image];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    CGRect bounds = textAttachment.bounds;
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        bounds.size = size;
        textAttachment.bounds = bounds;
    } else if (multiple <= 0) {
        CGFloat oldWidth = textAttachment.image.size.width;
        CGFloat scaleFactor = oldWidth / (self.frame.size.width - 10);
        textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    } else {
        bounds.size = image.size;
        textAttachment.bounds = bounds;
    }
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString replaceCharactersInRange:NSMakeRange(index, 0) withAttributedString:attrStringWithImage];
    self.attributedText = attributedString;
    [self textViewTextChange];
    [self refreshPlaceholderView];
}


#pragma mark - KVO监听属性改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self refreshPlaceholderView];
    if ([keyPath isEqualToString:@"text"]) [self textViewTextChange];
}

// 刷新PlaceholderView
- (void)refreshPlaceholderView {
    
    UITextView *placeholderView = objc_getAssociatedObject(self, SKPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.sk_placeholderView.frame = self.bounds;
        if (self.sk_maxHeight < self.bounds.size.height) self.sk_maxHeight = self.bounds.size.height;
        self.sk_placeholderView.font = self.font;
        self.sk_placeholderView.textAlignment = self.textAlignment;
        self.sk_placeholderView.textContainerInset = self.textContainerInset;
        self.sk_placeholderView.hidden = (self.text.length > 0 && self.text);
    }
}

// 处理文字改变
- (void)textViewTextChange {
    UITextView *placeholderView = objc_getAssociatedObject(self, SKPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.sk_placeholderView.hidden = (self.text.length > 0 && self.text);
    }
    // 如果没有启用自动高度，不执行以下方法
    if (!autoHeight) return;
    if (self.sk_maxHeight >= self.bounds.size.height) {
        
        // 计算高度
        NSInteger currentHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
        
        // 如果高度有变化，调用block
        if (currentHeight != self.lastHeight) {
            // 是否可以滚动
            self.scrollEnabled = currentHeight >= self.sk_maxHeight;
            CGFloat currentTextViewHeight = currentHeight >= self.sk_maxHeight ? self.sk_maxHeight : currentHeight;
            // 改变textView的高度
            if (currentTextViewHeight >= self.sk_minHeight) {
                CGRect frame = self.frame;
                frame.size.height = currentTextViewHeight;
                self.frame = frame;
                // 调用block
                if (self.sk_textViewHeightDidChanged) self.sk_textViewHeightDidChanged(currentTextViewHeight);
                // 记录当前高度
                self.lastHeight = currentTextViewHeight;
            }
        }
    }
    
    if (!self.isFirstResponder) [self becomeFirstResponder];
}

// 判断是否有placeholder值，这步很重要
- (BOOL)placeholderExist {
    
    // 获取对应属性的值
    UITextView *placeholderView = objc_getAssociatedObject(self, SKPlaceholderViewKey);
    
    // 如果有placeholder值
    if (placeholderView) return YES;
    
    return NO;
}

@end
