//
//  WGInputAlertView.m
//  CustomIOSAlertView
//
//  Created by 胡文广 on 2017/12/29.
//  Copyright © 2017年 Wimagguc. All rights reserved.
//

#import "WGInputAlertView.h"

@implementation WGInputAlertView

+ (instancetype)inputAlertView{
    return [[NSBundle mainBundle] loadNibNamed:@"WGInputAlertView" owner:nil options:nil][0];
}

@end
