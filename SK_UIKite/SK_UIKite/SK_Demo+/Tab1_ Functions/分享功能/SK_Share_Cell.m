//
//  SK_Share_Cell.m
//  SK_UIKite
//
//  Created by Skylin on 2018/7/16.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_Share_Cell.h"

@implementation SK_Share_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configShareSDK:(NSString *)title
{
    self.ShareLabel.text = title;
}

-(void)configYouMeng:(NSString *)title
{
    self.YouMengLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
