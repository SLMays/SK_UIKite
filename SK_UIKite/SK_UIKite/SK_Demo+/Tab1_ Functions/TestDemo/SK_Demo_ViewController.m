//
//  SK_Demo_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/5/25.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_Demo_ViewController.h"


@interface SK_Demo_ViewController ()

@end

@implementation SK_Demo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableDictionary * mDict = [NSMutableDictionary new];
    [mDict setObject:@"v1" forKey:@"k1"];
    [mDict setObject:@"v2" forKey:@"k2"];
    [mDict setObject:@"v3" forKey:@"k3"];
    [mDict setObject:@"v4" forKey:@"k4"];
    [mDict setObject:@"v5" forKey:@"k5"];
    [mDict setObject:@"v6" forKey:@"k6"];
    [mDict setObject:@"v7" forKey:@"k7"];
    
    NSLog(@"%@",mDict);
    
    
    
    NSMutableDictionary * muDict = [[NSMutableDictionary alloc]initWithObjects:@[@"v1",@"v2",@"v3",@"v4",@"v5",@"v6",@"v7",] forKeys:@[@"k1",@"k2",@"k3",@"k4",@"k5",@"k6",@"k7"]];
    
    NSLog(@"%@",muDict);

    
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
