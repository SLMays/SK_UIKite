//
//  SK_OCR_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/23.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_OCR_ViewController.h"
#import "SK_IDCard_ViewController.h"
#import "SK_BankCard_ViewController.h"

@interface SK_OCR_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray * ActionListArr;
@property (nonatomic,strong) UITableView * mainTableView;
@end

@implementation SK_OCR_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTableView];
}

-(NSArray *)ActionListArr
{
    if (!_ActionListArr) {
        _ActionListArr = @[@{K_MenuTitle:@"身份证扫描识别",K_MenuClass:@"SK_IDCard_ViewController"},
                          @{K_MenuTitle:@"银行卡扫描识别",K_MenuClass:@"SK_BankCard_ViewController"}];
    }
    return _ActionListArr;
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [UITableView initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT) Style:(UITableViewStylePlain) Delegate:self SeparatorStyle:(SK_TableViewCellSeparatorStyle_Full)];
    }
    return _mainTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ActionListArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OCR_CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"OCR_CELL"];
    }
    
    cell.textLabel.text = [self.ActionListArr[indexPath.row] objectForKey:K_MenuTitle];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class class = NSClassFromString([self.ActionListArr[indexPath.row] objectForKey:K_MenuClass]);
    if (class) {
        UIViewController * vc = [[class alloc]init];
        vc.navigationItem.title = [self.ActionListArr[indexPath.row] objectForKey:K_MenuTitle];
        [self.navigationController pushViewController:vc animated:YES];
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
