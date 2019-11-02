//
//  WGInputAlertView.h
//  CustomIOSAlertView
//
//  Created by 胡文广 on 2017/12/29.
//  Copyright © 2017年 Wimagguc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WGInputAlertView_H 170
@interface WGInputAlertView : UIView
+ (instancetype)inputAlertView;
@property (weak, nonatomic) IBOutlet UITextField *topTextField;
@property (weak, nonatomic) IBOutlet UITextField *midTextField;
@property (weak, nonatomic) IBOutlet UITextField *bottomTextField;

@end
