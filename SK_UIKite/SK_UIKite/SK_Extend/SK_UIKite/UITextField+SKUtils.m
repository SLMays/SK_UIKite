//
//  UITextField+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "UITextField+SKUtils.h"
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

@implementation UITextField (SKUtils)

+ (UITextField*_Nullable)initWithFrame:(CGRect)frame placeholder:(NSString*_Nullable)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*_Nullable)imageView rightImageView:(UIImageView*_Nullable)rightImageView font:(float)font backgRoundImageName:(UIImage *_Nullable)bgImg text:(NSString *_Nullable)textStr textBorderStyle:(UITextBorderStyle)textBorderStyle keyboardType:(UIKeyboardType)keyboardType textAlignment:(NSTextAlignment)textAlignment bgColor:(NSString *_Nullable)bgColor borderColor:(NSString *_Nullable)borderColor tag:(NSInteger)tag
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //密码状态
    textField.secureTextEntry=YESorNO;
    //关闭首字母大写
    textField.autocapitalizationType= UITextAutocapitalizationTypeNone;//(UITextAutocapitalizationType) NO;
    //清除按钮
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //修改textfield的clearbtn颜色
//    UIButton *cleanBtn = [textField valueForKey:@"_clearButton"]; //key是固定的
//    cleanBtn.lee_theme.LeeConfigButtonImage(IconF_ClearBtn, UIControlStateNormal);
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    textField.rightViewMode=UITextFieldViewModeAlways;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
//    textField.lee_theme.LeeConfigTextColor(TextFieldMainTextColor);
    //placeholder颜色
//    textField.lee_theme.LeeConfigPlaceholderColor(TextFieldPlaceHolderColor);
    //背景颜色
    if (STRING_IS_NOT_EMPTY(bgColor)) {
        textField.lee_theme.LeeConfigBackgroundColor(bgColor);
    }else{
        textField.backgroundColor = [UIColor clearColor];
    }
    if (STRING_IS_NOT_EMPTY(borderColor)) {
//        textField.bThemeColor = borderColor;
    }
    //背景图片
    textField.background = bgImg;
    //默认文字
    textField.text = textStr;
    //tag值
    textField.tag = tag;
    //输入框类型
    /*
     UITextBorderStyleNone,         //无
     UITextBorderStyleLine,         //线
     UITextBorderStyleBezel,        //3D
     UITextBorderStyleRoundedRect   //圆角
     */
    textField.borderStyle = textBorderStyle;
    
    //键盘类型
    /*
     UIKeyboardTypeDefault;               //字母+数字（全）（小地球）
     UIKeyboardTypeASCIICapable;          //字母+数字（全）（密码）
     UIKeyboardTypeNumbersAndPunctuation; //数字+字母（全）
     UIKeyboardTypeURL;                   //URL地址（全）（小地球）
     UIKeyboardTypeNumberPad;             //数字（九）
     UIKeyboardTypePhonePad;              //数字+*#（九）（电话号码）
     UIKeyboardTypeDecimalPad;            //数字+.（九）
     */
    textField.keyboardType = keyboardType;
    
    //对齐方式
    /*
     NSTextAlignmentLeft;              //居左
     NSTextAlignmentCenter;            //居中
     NSTextAlignmentRight;             //居右
     */
    textField.textAlignment = textAlignment;
    
    return textField;
}
//placeholder颜色
-(void)placeholderColor:(UIColor *)color
{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}
//左边距
-(void)leftSpacing:(CGFloat)left
{
    self.leftView = [UIView initWithFrame:CGRectMake(0, 0, left, self.height) backgroundColor:nil alpha:0.0];
    self.leftViewMode = UITextFieldViewModeAlways;
}
//右边距
-(void)rightSpacing:(CGFloat)right
{
    self.rightView = [UIView initWithFrame:CGRectMake(0, 0, right, self.height) backgroundColor:nil alpha:0.0];
    self.rightViewMode = UITextFieldViewModeAlways;
}
//左图片
-(void)LeftImg:(UIImage *)leftImg
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, leftImg.size.width+5, leftImg.size.height)];
    imgView.image = leftImg;
    imgView.contentMode = UIViewContentModeCenter;
    self.leftView = imgView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
//右图片
-(void)RightImg:(UIImage *)rightImg
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rightImg.size.width+5, rightImg.size.height)];
    imgView.image = rightImg;
    imgView.contentMode = UIViewContentModeCenter;
    self.rightView = imgView;
    self.rightViewMode = UITextFieldViewModeAlways;
}
-(void)LeftIconFontImg:(NSString *_Nullable)leftImg  Size:(int)size
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
    imgView.lee_theme.LeeConfigImage(leftImg);
    imgView.contentMode = UIViewContentModeCenter;
    self.leftView = imgView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
-(void)RightIconFontImg:(NSString *_Nullable)rightImg  Size:(int)size
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
    imgView.lee_theme.LeeConfigImage(rightImg);
    imgView.contentMode = UIViewContentModeCenter;
    self.rightView = imgView;
    self.rightViewMode = UITextFieldViewModeAlways;
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

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
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
    });
    [super load];
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
    if (![self.moveView.gestureRecognizers containsObject:self.tapGesture]) {
        [self.moveView addGestureRecognizer:self.tapGesture];
    }
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
    objc_setAssociatedObject(self, &canMoveKey, @(canMove), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)canMove {
    return [objc_getAssociatedObject(self, &canMoveKey) boolValue];
}

- (void)setHeightToKeyboard:(CGFloat)heightToKeyboard {
    objc_setAssociatedObject(self, &heightToKeyboardKey, @(heightToKeyboard), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    objc_setAssociatedObject(self, &hasContentOffsetKey, @(hasContentOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hasContentOffset {
    return [objc_getAssociatedObject(self, &hasContentOffsetKey) boolValue];
}



@end
