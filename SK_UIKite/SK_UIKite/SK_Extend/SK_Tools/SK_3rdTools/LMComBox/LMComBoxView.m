//
//  LMComBoxView.m
//  ComboBox
//
//  Created by tkinghr on 14-7-9.
//  Copyright (c) 2014年 Eric Che. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "LMComBoxView.h"
#import "UIImageView+WebCache.h"

@implementation LMComBoxView

- (id)initWithFrame:(CGRect)frame DefineTitle:(NSString *)defineTitle   DefineIndex:(int)defineIndex TitleColor:(UIColor *)titColor TitleFont:(UIFont *)titFont TitleBgColor:(UIColor *)titBgColor ListTitleColor:(UIColor *)listTitColor ListBgColor:(UIColor *)listTitBgColor TextAlignment:(NSTextAlignment)alignment ArrowImgName:(NSString *)arrowImgName Open:(BOOL)open TitleList:(NSMutableArray *)titleList CellHeight:(CGFloat)cellHeight SupperView:(UIView *)supView
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        
        CGFloat titleWidth = self.frame.size.width - 33;
        
        UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        subView.userInteractionEnabled = YES;
        [bgView addSubview:subView];
        
        //选中的文字
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleWidth, self.frame.size.height)];
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.font = titFont;
        _titleLabel.backgroundColor = titBgColor;
        _titleLabel.textAlignment = alignment;
        _titleLabel.textColor = titColor;
        [subView addSubview:_titleLabel];
        
        //icon
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.left+10, (self.height-imgH)/2.0, imgW, imgH)];
        _arrow.image = [UIImage imageNamed:arrowImgName];
        _arrow.userInteractionEnabled = YES;
        [subView addSubview:_arrow];
        
        //默认不展开
        _isOpen = open;
        
        //列表
        _supView = supView;
        _titlesList = titleList;
        _tableHeight = cellHeight;
        _defaultIndex = defineIndex;
        _listTitColor = listTitColor;
        
        _listTable = [[SK_TableView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 0) style:UITableViewStylePlain];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.backgroundColor = listTitBgColor;
        _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_supView addSubview:_listTable];
        
        if (_defaultIndex>=0) {
            _titleLabel.text = [_titlesList objectAtIndex:defineIndex];
        }else{
            _titleLabel.text = defineTitle;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
    }
    return self;
}

//刷新视图
-(void)reloadData
{
    [_listTable reloadData];
    _titleLabel.text = [_titlesList objectAtIndex:_defaultIndex];
}

//关闭父视图上面的其他combox
-(void)closeOtherCombox
{
    for(UIView *subView in _supView.subviews)
    {
        if([subView isKindOfClass:[LMComBoxView class]]&&subView!=self)
        {
            LMComBoxView *otherCombox = (LMComBoxView *)subView;
            if(otherCombox.isOpen)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect frame = otherCombox.listTable.frame;
                    frame.size.height = 0;
                    [otherCombox.listTable setFrame:frame];
                } completion:^(BOOL finished){
                    [otherCombox.listTable removeFromSuperview];
                    otherCombox.isOpen = NO;
                    otherCombox.arrow.transform = CGAffineTransformRotate(otherCombox.arrow.transform, DEGREES_TO_RADIANS(180));
                }];
            }
        }
    }
}

//点击事件
-(void)tapAction
{
    //关闭其他combox
    //    [self closeOtherCombox];
    
    if(_isOpen)
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _listTable.frame;
            frame.size.height = 0;
            [_listTable setFrame:frame];
        } completion:^(BOOL finished){
            [_listTable removeFromSuperview];//移除
            _isOpen = NO;
            _arrow.transform = CGAffineTransformRotate(_arrow.transform, DEGREES_TO_RADIANS(180));
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            if(_titlesList.count>0)
            {
                /*
                 
                 注意：如果不加这句话，下面的操作会导致_listTable从上面飘下来的感觉：
                 _listTable展开并且滑动到底部 -> 点击收起 -> 再点击展开
                 */
                [_listTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
            [_supView addSubview:_listTable];
            [_supView bringSubviewToFront:_listTable];//避免被其他子视图遮盖住
            CGRect frame = _listTable.frame;
            frame.size.height = _titlesList.count>5?5*_tableHeight:_titlesList.count*_tableHeight;
            float height = [UIScreen mainScreen].bounds.size.height;
            if(frame.origin.y+frame.size.height>height)
            {
                //避免超出屏幕外
                frame.size.height -= frame.origin.y + frame.size.height - height;
            }
            [_listTable setFrame:frame];
        } completion:^(BOOL finished){
            _isOpen = YES;
            _arrow.transform = CGAffineTransformRotate(_arrow.transform, DEGREES_TO_RADIANS(180));
        }];
    }
}
- (void)setIsOpen:(BOOL)isOpen
{
    _isOpen=isOpen;
    [self tapAction];
}
- (void)setTitlesList:(NSMutableArray *)titlesList
{
    _titlesList = titlesList;
    [self reloadData];
}

#pragma mark -tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titlesList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _tableHeight)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = _listTitColor;
        label.tag = 1000;
        [cell addSubview:label];
        
        UIView *views = [[UIView alloc]initWithFrame:cell.bounds];
        views.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = views;
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = [_titlesList objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    titleLabel.text = [[_titlesList objectAtIndex:indexPath.row] objectForKey:@"name"];
    _defaultIndex = (int)indexPath.row;
    [self reloadData];
    
    _isOpen = YES;
    [self tapAction];
    if([_delegate respondsToSelector:@selector(selectAtIndex:inCombox:)])
    {
        [_delegate selectAtIndex:(int)indexPath.row inCombox:self];
    }
    [self performSelector:@selector(deSelectedRow) withObject:nil afterDelay:0.2];
}

-(void)deSelectedRow
{
    [_listTable deselectRowAtIndexPath:[_listTable indexPathForSelectedRow] animated:YES];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
