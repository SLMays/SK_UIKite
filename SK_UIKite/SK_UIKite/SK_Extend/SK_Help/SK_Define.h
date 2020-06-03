//
//  SK_Define.h
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/2/8.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  忽略performSelector警告
 */
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#pragma mark - 系统版本号
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark - 设备型号识别
#define Device_iPhone_3_5 (WIDTH_IPHONE==320&&HEIGHT_IPHONE==480)
#define Device_iPhone_4_0 (WIDTH_IPHONE==320&&HEIGHT_IPHONE==568)
#define Device_iPhone_4_7 (WIDTH_IPHONE==375&&HEIGHT_IPHONE==667)
#define Device_iPhone_5_5 (WIDTH_IPHONE==414&&HEIGHT_IPHONE==736)
#define Device_iPhone_5_8 (WIDTH_IPHONE==375&&HEIGHT_IPHONE==812)

#pragma mark - 系统控件
#define Height_TabBar           [SK_Define TabBarHeight]
#define Height_NavigationBar    [SK_Define NavightionHeight]
#define Height_StatusBar        [SK_Define StatusHeight]
#define HAVE_TABBAR_HEIGHT      (HEIGHT_IPHONE-Height_NavigationBar-Height_TabBar)
#define NOHAVE_TABBAR_HEIGHT    (HAVE_TABBAR_HEIGHT+49)
#define WIDTH_IPHONE            ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT_IPHONE           ([UIScreen mainScreen].bounds.size.height)
#define ScreenRatio_HW          (HEIGHT_IPHONE/WIDTH_IPHONE)
#define ScreenRatio_WH          (WIDTH_IPHONE/HEIGHT_IPHONE)
#define Width_Alert             (WIDTH_IPHONE*3/4)

#pragma mark- 随机
#define RandomColor  [UIColor colorWithHue: (arc4random()% 256/256.0) saturation:(arc4random()%128/256.0)+0.5 brightness:(arc4random()%128/256.0)+ 0.5 alpha:1]
#define RandomNumber(n) [NSString stringWithFormat:@"%u",(arc4random() % n)]

#pragma mark - 颜色
#define COLORWITHRGBA(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define COLORWITHHEXSTRING(HEX) [UIColor colorWithHexString:HEX]

#pragma mark - UserDefaults的存储和读取
#define SaveUserDefaults(key,value) [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];[[NSUserDefaults standardUserDefaults] synchronize]
#define GetUserDefaults(key)[[NSUserDefaults standardUserDefaults]objectForKey:key]
#define RemoveUserDefaults(key)[[NSUserDefaults standardUserDefaults]removeObjectForKey:key]

#pragma mark - NSNotificationCenter通知中心
#define Notification_ADD(observer,aSelector,aName,anObject) [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(aSelector) name:aName object:anObject];
#define Notification_POST(aName,anObject) [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
#define Notification_POST_Info(aName,anObject,aUserInfo) [[NSNotificationCenter defaultCenter]postNotificationName:aName object:anObject userInfo:aUserInfo];
#define Notification_REMOVE(observer,aName,anObject) [[NSNotificationCenter defaultCenter]removeObserver:observer name:aName object:anObject]
#define Notification_REMOVEAll(vc) [[NSNotificationCenter defaultCenter]removeObserver:vc]

#pragma mark - 判断数据是否为空
#define STRING_IS_NOT_EMPTY(string) (string !=nil && [string isKindOfClass:[NSString class]] && ![string isEqualToString:@""] && ![string isKindOfClass:[NSNull class]])
#define ARRAY_IS_NOT_EMPTY(array) (array && [array isKindOfClass:[NSArray class]] && [array count] && ![array isKindOfClass:[NSNull class]])
#define DICT_IS_NOT_EMPTY(responseObject) ([responseObject isKindOfClass:[NSDictionary class]]&&[responseObject count] && ![responseObject isKindOfClass:[NSNull class]])
#define DICT_HAVE_KEY(dict,key) ([[dict allKeys] containsObject:key])

#pragma mark - 弱引用Self
#define SK_WEAKSELF    __weak __typeof(&*self)_weakSelf = self;

#pragma mark - Toast提示
#define SKToast(Msg)  SK_TOAST_SHOW_BOTTOM(Msg)
#define SKToast_Error(error)  SKToast([SK_HTTPClient getErrorContentWith:error])

#pragma mark - Cell的两种实例化方法
#define CELL_NAME(UITableViewCell,identStr,color)     static NSString *identifier = identStr;\
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];\
if (cell == NULL){\
cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];\
cell.selectionStyle = UITableViewCellSelectionStyleNone;\
cell.backgroundColor = color;\
}

#define CELL_XIB(TableViewCellClass,cellName,color)     static NSString *identifier = cellName;\
TableViewCellClass *cell = [tableView dequeueReusableCellWithIdentifier:identifier];\
if (cell == NULL){\
cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([TableViewCellClass class]) owner:self options:nil]lastObject];\
cell.selectionStyle = UITableViewCellSelectionStyleNone;\
cell.backgroundColor = color;\
}

//key宏
#define K_MenuTitle @"Title"
#define K_MenuClass @"Class"

//卡片长宽比
#define K_CARDRATIO (85.6/54.0)

@interface SK_Define : NSObject

#pragma mark - --判断导航的高度64or44
+(float)NavightionHeight;
#pragma mark - 判断TabBar高度
+(float)TabBarHeight;
#pragma 判断StatusBar高度
+(float)StatusHeight;


@end
