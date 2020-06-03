//
//  UITextView+SKUtils.m
//  SK_UIKite
//
//  Created by 美美证券 on 2018/4/25.
//  Copyright © 2018年 ShiLei. All rights reserved.
//

#import "UITextView+SKUtils.h"
#import <objc/runtime.h>

static char canMoveKey;
static char moveViewKey;
static char heightToKeyboardKey;
static char initialYKey;
static char tapGestureKey;
static char keyboardYKey;
static char totalHeightKey;
static char keyboardHeightKey;
static char hasContentOffsetKey;

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

//是否禁用复制，剪切，粘贴等操作
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender

{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

+(UITextView *)initWithFrame:(CGRect)frame text:(NSString *)text textHexColor:(NSString *)textHexColor font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment editable:(BOOL)editable userInteractionEnabled:(BOOL)userInteractionEnabled  tag:(int)tag
{
    UITextView * textV = [[UITextView alloc]initWithFrame:frame];
    textV.text = text;
    if (textHexColor) {
        textV.lee_theme.LeeConfigTextColor(textHexColor);
    }else{
        textV.textColor = [UIColor blackColor];
    }
    [textV setContentOffset:CGPointMake(0, 5) animated:NO];
    textV.showsVerticalScrollIndicator = NO;
    textV.showsHorizontalScrollIndicator = NO;
    textV.backgroundColor = [UIColor clearColor];
    textV.editable = editable;
    textV.textAlignment = textAlignment;
    textV.userInteractionEnabled = userInteractionEnabled;
    textV.font = [UIFont systemFontOfSize:font];
    textV.tag = tag;

    return textV;
}




#pragma mark - 【键盘弹起回收问题】
@dynamic canMove;
@dynamic moveView;
@dynamic heightToKeyboard;
@dynamic initialY;
@dynamic tapGesture;
@dynamic keyboardY;
@dynamic totalHeight;
@dynamic keyboardHeight;
@dynamic hasContentOffset;

+(void)load {
    
    /**
     交换dealoc
     */
    Method dealoc = class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc"));
    Method myDealloc = class_getInstanceMethod(self.class, @selector(myDealloc));
    method_exchangeImplementations(dealoc, myDealloc);
    
    
    /**
     键盘监听
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if(IOS_VERSION >=9){
            SEL systemSel = @selector(initWithFrame:);
            SEL mySel = @selector(setupInitWithFrame:);
            [self exchangeSystemSel:systemSel bySel:mySel];
            
            SEL systemSel2 = @selector(becomeFirstResponder);
            SEL mySel2 = @selector(newBecomeFirstResponder);
            [self exchangeSystemSel:systemSel2 bySel:mySel2];
            
            SEL systemSel3 = @selector(resignFirstResponder);
            SEL mySel3 = @selector(newResignFirstResponder);
            [self exchangeSystemSel:systemSel3 bySel:mySel3];
            
            SEL systemSel4 = @selector(initWithCoder:);
            SEL mySel4 = @selector(setupInitWithCoder:);
            [self exchangeSystemSel:systemSel4 bySel:mySel4];
        }
    });
}

// 交换方法
+ (void)exchangeSystemSel:(SEL)systemSel bySel:(SEL)mySel {
    Method systemMethod = class_getInstanceMethod([self class], systemSel);
    Method myMethod = class_getInstanceMethod([self class], mySel);
    //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
    BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    if (isAdd) {
        //如果成功，说明类中不存在这个方法的实现
        //将被交换方法的实现替换到这个并不存在的实现
        class_replaceMethod(self, mySel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        //否则，交换两个方法的实现
        method_exchangeImplementations(systemMethod, myMethod);
    }
}

- (instancetype)setupInitWithCoder:(NSCoder *)aDecoder {
    [self setup];
    return [self setupInitWithCoder:aDecoder];
}

- (instancetype)setupInitWithFrame:(CGRect)frame {
    [self setup];
    return [self setupInitWithFrame:frame];
}

- (void)setup {
    self.heightToKeyboard = 10;
    self.canMove = YES;
    self.keyboardY = 0;
    self.totalHeight = 0;
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
}

- (void)showAction:(NSNotification *)sender {
    NSLog(@"%@", sender);
    if (!self.canMove) {
        return;
    }
    self.keyboardY = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    self.keyboardHeight = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self keyboardDidShow];
}

- (void)hideAction:(NSNotification *)sender {
    if (!self.canMove || self.keyboardY == 0) {
        return;
    }
    [self hideKeyBoard:0.25];
}

- (void)keyboardDidShow {
    if (self.keyboardHeight == 0) {
        return;
    }
    CGFloat fieldYInWindow = [self convertPoint:self.bounds.origin toView:[UIApplication sharedApplication].keyWindow].y;
    CGFloat height = (fieldYInWindow + self.heightToKeyboard + self.frame.size.height) - self.keyboardY;
    CGFloat moveHeight = height > 0 ? height : 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.hasContentOffset) {
            UIScrollView *scrollView = (UIScrollView *)self.moveView;
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + moveHeight);
        } else {
            CGRect rect = self.moveView.frame;
            self.initialY = rect.origin.y;
            rect.origin.y -= moveHeight;
            self.moveView.frame = rect;
        }
        self.totalHeight += moveHeight;
    }];
}

- (void)hideKeyBoard:(CGFloat)duration {
    [UIView animateWithDuration:duration animations:^{
        if (self.hasContentOffset) {
            UIScrollView *scrollView = (UIScrollView *)self.moveView;
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y - self.totalHeight);
        } else {
            CGRect rect = self.moveView.frame;
            rect.origin.y += self.totalHeight;
            self.moveView.frame = rect;
        }
        self.totalHeight = 0;
    }];
}

- (BOOL)newBecomeFirstResponder {
    if (self.moveView == nil) {
        self.moveView = [self viewController].view;
    }
    //    if (![self.moveView.gestureRecognizers containsObject:self.tapGesture]) {
    //        [self.moveView addGestureRecognizer:self.tapGesture];
    //    }
    if ([self isFirstResponder] || !self.canMove) {
        return [self newBecomeFirstResponder];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAction:) name:UIKeyboardWillHideNotification object:nil];
    return [self newBecomeFirstResponder];
}

- (BOOL)newResignFirstResponder {
    if ([self.moveView.gestureRecognizers containsObject:self.tapGesture]) {
        [self.moveView removeGestureRecognizer:self.tapGesture];
    }
    if (!self.canMove) {
        return [self newResignFirstResponder];
    }
    BOOL result = [self newResignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self hideKeyBoard:0];
    return result;
}

- (void)tapAction {
    [[self viewController].view endEditing:YES];
}

- (UIViewController *)viewController {
    UIView *next = self;
    while (1) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }else if ([nextResponder isKindOfClass:[UIWindow class]]){
            return nil;
        }
        next = next.superview;
    }
    return nil;
}

- (void)setCanMove:(BOOL)canMove {
    objc_setAssociatedObject(self, &canMoveKey, @(canMove), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canMove {
    return [objc_getAssociatedObject(self, &canMoveKey) boolValue];
}

- (void)setHeightToKeyboard:(CGFloat)heightToKeyboard {
    objc_setAssociatedObject(self, &heightToKeyboardKey, @(heightToKeyboard), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)heightToKeyboard {
    return [objc_getAssociatedObject(self, &heightToKeyboardKey) floatValue];
}

- (void)setMoveView:(UIView *)moveView {
    self.hasContentOffset = NO;
    if ([moveView isKindOfClass:[UIScrollView class]]) {
        self.hasContentOffset = YES;
    }
    
    objc_setAssociatedObject(self, &moveViewKey, moveView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)moveView {
    return objc_getAssociatedObject(self, &moveViewKey);
}

- (void)setInitialY:(CGFloat)initialY {
    objc_setAssociatedObject(self, &initialYKey, @(initialY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)initialY {
    return [objc_getAssociatedObject(self, &initialYKey) floatValue];
}

- (void)setTapGesture:(UITapGestureRecognizer *)tapGesture {
    objc_setAssociatedObject(self, &tapGestureKey, tapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tapGesture {
    return objc_getAssociatedObject(self, &tapGestureKey);
}

- (void)setKeyboardY:(CGFloat)keyboardY {
    objc_setAssociatedObject(self, &keyboardYKey, @(keyboardY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)keyboardY {
    return [objc_getAssociatedObject(self, &keyboardYKey) floatValue];
}

- (void)setTotalHeight:(CGFloat)totalHeight {
    objc_setAssociatedObject(self, &totalHeightKey, @(totalHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)totalHeight {
    return [objc_getAssociatedObject(self, &totalHeightKey) floatValue];
}

- (void)setKeyboardHeight:(CGFloat)keyboardHeight {
    objc_setAssociatedObject(self, &keyboardHeightKey, @(keyboardHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)keyboardHeight {
    return [objc_getAssociatedObject(self, &keyboardHeightKey) floatValue];
}

- (void)setHasContentOffset:(BOOL)hasContentOffset {
    objc_setAssociatedObject(self, &hasContentOffsetKey, @(hasContentOffset), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hasContentOffset {
    return [objc_getAssociatedObject(self, &hasContentOffsetKey) boolValue];
}







@end
