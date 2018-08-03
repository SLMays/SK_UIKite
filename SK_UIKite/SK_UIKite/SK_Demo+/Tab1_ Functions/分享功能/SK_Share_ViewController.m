//
//  SK_Share_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/7/16.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_Share_ViewController.h"
#import "SK_Share_Cell.h"

#define  TABLEVIEWWIDTH (WIDTH_IPHONE/2-0.5)

@interface SK_Share_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *ShareTableView;
@property (nonatomic, strong) UITableView *YouMengTableView;
@property (nonatomic, strong) NSArray *ShareArr;
@property (nonatomic, strong) NSArray *YouMengArr;
@end

@implementation SK_Share_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.ShareTableView];
    [self.view addSubview:self.YouMengTableView];
}
-(UITableView *)ShareTableView
{
    if (!_ShareTableView) {
        _ShareTableView = [UITableView initWithFrame:CGRectMake(0, 0, TABLEVIEWWIDTH, TABLEVIEWWIDTH) Style:(UITableViewStylePlain) Delegate:self SeparatorStyle:(SK_TableViewCellSeparatorStyle_Full)];
    }
    return _ShareTableView;
}
-(UITableView *)YouMengTableView
{
    if (!_YouMengTableView) {
        _YouMengTableView = [UITableView initWithFrame:CGRectMake(TABLEVIEWWIDTH+1, 0, TABLEVIEWWIDTH, NOHAVE_TABBAR_HEIGHT) Style:(UITableViewStylePlain) Delegate:self SeparatorStyle:(SK_TableViewCellSeparatorStyle_Full)];
    }
    return _YouMengTableView;
}
-(NSArray *)ShareArr
{
    return @[@"分享菜单",@"截屏分享",@"微信好友",@"微信朋友圈",@"登录授权",@"授权信息"];
}
-(NSArray *)YouMengArr
{
    return @[];
}

#pragma mark - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.ShareTableView) {
        return self.ShareArr.count;
    }else{
        return self.YouMengArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.ShareTableView) {
        CELL_XIB(SK_Share_Cell, @"ShaerCell", [UIColor whiteColor]);
        [cell configShareSDK:self.ShareArr[indexPath.row]];
        return cell;
    }else{
        CELL_XIB(SK_Share_Cell, @"YouMengCell", [UIColor whiteColor]);
        [cell configShareSDK:self.YouMengArr[indexPath.row]];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.ShareTableView) {
        
    }else{
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
