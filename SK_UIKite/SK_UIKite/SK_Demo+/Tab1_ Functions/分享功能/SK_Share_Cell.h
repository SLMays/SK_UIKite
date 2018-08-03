//
//  SK_Share_Cell.h
//  SK_UIKite
//
//  Created by Skylin on 2018/7/16.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK_Share_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ShareLabel;
@property (weak, nonatomic) IBOutlet UILabel *YouMengLabel;

-(void)configShareSDK:(NSString *)title;
-(void)configYouMeng:(NSString *)title;

@end
