//
//  SK_Vertical_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/7/4.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_Vertical_ViewController.h"
#import "SK_Landscape_ViewController.h"

@interface SK_Vertical_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation SK_Vertical_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"竖屏";
    self.view.backgroundColor =RandomColor;
    [self.view addSubview:self.mainTableView];
}


-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [UITableView initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT) Style:(UITableViewStylePlain) Delegate:self SeparatorStyle:(SK_TableViewCellSeparatorStyle_Full)];
        return _mainTableView;
    }
    return _mainTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"CELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",indexPath.row+1];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SK_Landscape_ViewController * land = [[SK_Landscape_ViewController alloc]init];
//    [self.navigationController pushViewController:land animated:YES];
    
    SK_NavigationController * nav = [[SK_NavigationController alloc]initWithRootViewController:[[SK_Landscape_ViewController alloc]init]];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
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
