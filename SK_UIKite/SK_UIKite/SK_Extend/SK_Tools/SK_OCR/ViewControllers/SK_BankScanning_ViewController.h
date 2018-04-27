//
//  SK_BankScanning_ViewController.h
//  SK_UIKite
//
//  Created by Skylin on 2018/4/25.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_ViewController.h"
@class XLScanResultModel;

typedef void(^BankScanningBlock)(XLScanResultModel * info);

@interface SK_BankScanning_ViewController : SK_ViewController

@property (nonatomic, copy) BankScanningBlock bankInfoblock;

@end
