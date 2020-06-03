//
//  UIImage+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/2/8.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SK_IconInfo;

typedef enum  {
    SK_GradientType_topToBottom         = 0,//从上到下
    SK_GradientType_leftToRight         = 1,//从左到右
    SK_GradientType_upleftTolowRight    = 2,//左上到右下
    SK_GradientType_uprightTolowLeft    = 3,//右上到左下
}SK_GradientType;

typedef enum  {
    SK_DirectionType_TopToBottom         = 0,//上下拼接
    SK_DirectionType_LeftToRight         = 1,//左右拼接
}SK_DirectionType;



typedef NS_ENUM(NSInteger, directionType) {
    directionTypeUpAndDown = 0,
    directionTypeLeftAndRight = 1,
};

@interface UIImage (SKUtils)

#pragma mark - 生成单一颜色的图片
+(UIImage *)imageWithColor:(UIColor *)color;
#pragma mark - 生成渐变颜色的图片
+(UIImage*)GradientImageFromColors:(NSArray*)colors ByGradientType:(SK_GradientType)gradientType frame:(CGRect)frame;
#pragma mark - 图片中心点拉伸
+(UIImage *)scalingImagWithName:(NSString *)name;
#pragma mark - 对图片进行滤镜处理
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;

#pragma mark - 对图片进行模糊处理
// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius;

#pragma mark - 调整图片饱和度、亮度、对比度
/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param image      目标图片
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;

#pragma mark - 创建一张实时模糊效果 View (毛玻璃效果)
//Avilable in iOS 8.0 and later
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;

#pragma mark - 全屏截图
+ (UIImage *)shotScreen;
+ (UIImage *)imageWithScreenshot;

#pragma mark - 截取一张 view 生成图片
+ (UIImage *)shotWithView:(UIView *)view;

/*
 参数说明
 1.view:你想截取的普通view
 2.screenSize:你想截取的大小，默认是整个view,若传入宽高小于view宽高则会舍弃view的右边或下边部分
 3.size:你想要的截图的大小，单位是KB
 */
#pragma mark - 截取普通View图片
+ (UIImage *)screenShotForView:(UIView *)view screenRect:(CGSize )screenSize imageKB:(NSInteger)size;

/*
 参数说明
 1.tableView或collectionView：你想要截图的view
 2.screenEdge:你想截取的长图距view的各边距离(只有右边和下边起作用)，默认是整个tableView,若传入宽高小于tableView宽高则会舍弃tableView的右边或下边部分
 3.size：你想得到的图片大小，单位是KB
 */
#pragma mark - 截取tableView长图
+ (UIImage *)screenShotForTableView:(UITableView *)tableView screenRect:(UIEdgeInsets )screenEdge imageKB:(NSInteger)size;
#pragma mark - 截取collectionView长图
+ (UIImage *)screenShotForCollectionView:(UICollectionView *)collectionView screenRect:(UIEdgeInsets )screenEdge imageKB:(NSInteger)size;

/**
 拼接两张图
 
 @param slaveImage 要拼接的内容
 @param masterImage 拼接到的内容主体
 @param direction 拼接方向
 @return 拼接后的图片
 */
#pragma mark - 拼接两张图片
+ (UIImage *)addSlaveImage:(UIImage *)slaveImage toMasterImage:(UIImage *)masterImage directionType:(SK_DirectionType)direction;

#pragma mark - 压缩图片到指定尺寸大小
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

#pragma mark - 压缩图片到指定文件大小
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

#pragma mark --指定长宽按比例缩放
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetSize:(CGSize)imgSize;

#pragma mark - 将图片背景修改成透明色
+ (UIImage*) imageToTransparent:(UIImage*) image;

#pragma mark - 使用iconFont绘制的图片
+ (UIImage *)iconWithInfo:(SK_IconInfo *)info;

#pragma mark - Blur Image

/**
 *  Get blured image.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImage;

/**
 *  Get the blured image masked by another image.
 *
 *  @param maskImage Image used for mask.
 *
 *  @return the Blured image.
 */
- (UIImage *)blurImageWithMask:(UIImage *)maskImage;

/**
 *  Get blured image and you can set the blur radius.
 *
 *  @param radius Blur radius.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImageWithRadius:(CGFloat)radius;

/**
 *  Get blured image at specified frame.
 *
 *  @param frame The specified frame that you use to blur.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImageAtFrame:(CGRect)frame;

#pragma mark - Grayscale Image

/**
 *  Get grayScale image.
 *
 *  @return GrayScaled image.
 */
- (UIImage *)grayScale;

#pragma mark - Some Useful Method

/**
 *  Scale image with fixed width.
 *
 *  @param width The fixed width you give.
 *
 *  @return Scaled image.
 */
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;

/**
 *  Scale image with fixed height.
 *
 *  @param height The fixed height you give.
 *
 *  @return Scaled image.
 */
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;

/**
 *  Get the image average color.
 *
 *  @return Average color from the image.
 */
- (UIColor *)averageColor;

/**
 *  Get cropped image at specified frame.
 *
 *  @param frame The specified frame that you use to crop.
 *
 *  @return Cropped image
 */
- (UIImage *)croppedImageAtFrame:(CGRect)frame;

#pragma mark - 给图片加水印图片
/**
 *  给图片加水印图片
 *
 *  @param image   水印图片
 *  @param imgRect 水印图片所在位置，大小
 *  @param alpha   水印图片的透明度，0~1之间，透明度太大会完全遮盖被加水印图片的那一部分
 *
 *  @return 加完水印的图片
 */
- (UIImage*)imageWaterMarkWithImage:(UIImage *)image imageRect:(CGRect)imgRect alpha:(CGFloat)alpha;
/**
 *  同上
 *
 *  @param image    同上
 *  @param imgPoint 水印图片（0，0）所在位置
 *  @param alpha    同上
 *
 *  @return 同上
 */
- (UIImage*)imageWaterMarkWithImage:(UIImage*)image imagePoint:(CGPoint)imgPoint alpha:(CGFloat)alpha;

/**
 *  给图片加文字水印
 *
 *  @param str     水印文字
 *  @param strRect 文字所在的位置大小
 *  @param attri   文字的相关属性，自行设置
 *
 *  @return 加完水印文字的图片
 */
- (UIImage*)imageWaterMarkWithString:(NSString*)str rect:(CGRect)strRect attribute:(NSDictionary *)attri;
/**
 *  同上
 *
 *  @param str      同上
 *  @param strPoint 文字（0，0）点所在位置
 *  @param attri    同上
 *
 *  @return 同上
 */
- (UIImage*)imageWaterMarkWithString:(NSString*)str point:(CGPoint)strPoint attribute:(NSDictionary*)attri;
/**
 *  返回加水印文字和图片的图片
 *
 *  @param str      水印文字
 *  @param strPoint 文字（0，0）点所在位置
 *  @param attri    文字属性
 *  @param image    水印图片
 *  @param imgPoint 图片（0，0）点所在位置
 *  @param alpha    透明度
 *
 *  @return 加完水印的图片
 */
- (UIImage*)imageWaterMarkWithString:(NSString*)str point:(CGPoint)strPoint attribute:(NSDictionary*)attri image:(UIImage*)image imagePoint:(CGPoint)imgPoint alpha:(CGFloat)alpha;
/**
 *  同上
 *
 *  @param str     同上
 *  @param strRect 文字的位置大小
 *  @param attri   同上
 *  @param image   同上
 *  @param imgRect 图片的位置大小
 *  @param alpha   透明度
 *
 *  @return 同上
 */
- (UIImage*)imageWaterMarkWithString:(NSString*)str rect:(CGRect)strRect attribute:(NSDictionary *)attri image:(UIImage *)image imageRect:(CGRect)imgRect alpha:(CGFloat)alpha;

/**
 根据目标图片制作一个盖水印的图片(45°倾斜)
 
 @param title 水印文字
 @param markFont 水印文字font(如果不传默认为23)
 @param markColor 水印文字颜色(如果不传递默认为源图片的对比色)
 @return 返回盖水印的图片
 */
- (UIImage *)WaterMarkWithTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor;

//根据图片获取图片的主色调
+(UIColor*)mostColor:(UIImage*)image;

/**
 生成二维码(中间有小图片)
 QRStering：字符串
 centerImage：二维码中间的image对象
 */
+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage;
@end
