//
//  LMComBoxView.h
//  ComboBox
//
//  Created by tkinghr on 14-7-9.
//  Copyright (c) 2014年 Eric Che. All rights reserved.
//  实现下拉框ComBox

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
#define imgW 13
#define imgH 8
#define tableH 150
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)


@class LMComBoxView;
@protocol LMComBoxViewDelegate <NSObject>

-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox;

@end

@interface LMComBoxView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * logoImgView;
}
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)int defaultIndex;
@property(nonatomic,assign)float tableHeight;
@property(nonatomic,strong)UIView *supView;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UITableView *listTable;
@property(nonatomic, strong)UIColor * listTitColor;
@property(nonatomic,strong)NSMutableArray *titlesList;
@property(nonatomic,assign)id<LMComBoxViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame DefineTitle:(NSString *)defineTitle   DefineIndex:(int)defineIndex TitleColor:(UIColor *)titColor TitleFont:(UIFont *)titFont TitleBgColor:(UIColor *)titBgColor ListTitleColor:(UIColor *)listTitColor ListBgColor:(UIColor *)listTitBgColor TextAlignment:(NSTextAlignment)alignment ArrowImgName:(NSString *)arrowImgName Open:(BOOL)open TitleList:(NSMutableArray *)titleList CellHeight:(CGFloat)cellHeight SupperView:(UIView *)supView;

-(void)reloadData;
-(void)closeOtherCombox;
-(void)tapAction;

@end


/*
    注意：
    1.单元格默认跟控件本身的高度一致
 */
