//
//  SK_TableView_Controller.m
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/2/8.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_TableView_Controller.h"

@interface SK_TableView_Controller ()

@end

@implementation SK_TableView_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTableView];
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(NSMutableArray *)FunctionClassArr
{
    if (!_FunctionClassArr) {
        _FunctionClassArr = [NSMutableArray new];
    }
    return _FunctionClassArr;
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT) style:(UITableViewStylePlain)];
        _mainTableView.tableFooterView = [[UIView alloc]init];
        _mainTableView.backgroundColor = [UIColor whiteColor];
    }
    return _mainTableView;
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
