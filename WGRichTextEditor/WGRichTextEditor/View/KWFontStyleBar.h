//
//  KWFontStyleBar.h
//  KaiWen
//
//  Created by 胡文广 on 2017/12/27.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import <UIKit/UIKit.h>

//当前view高度
#define KWFontBar_Height 44

@class KWFontStyleBar;
@protocol KWFontStyleBarDelegate<NSObject>
- (void)fontBar:(KWFontStyleBar *)fontBar didClickBtn:(UIButton *)button;
- (void)fontBarResetNormalFontSize;
@end
@interface KWFontStyleBar : UIView
@property (nonatomic,weak) id<KWFontStyleBarDelegate> delegate;

@property (nonatomic,strong) UIButton *boldItem;
@property (nonatomic,strong) UIButton *underlineItem;
@property (nonatomic,strong) UIButton *italicItem;
@property (nonatomic,strong) UIButton *justifyLeftItem;
@property (nonatomic,strong) UIButton *justifyCenterItem;
@property (nonatomic,strong) UIButton *justifyRightItem;
@property (nonatomic,strong) UIButton *indentItem;
@property (nonatomic,strong) UIButton *outdentItem;
@property (nonatomic,strong) UIButton *unorderlistItem;
@property (nonatomic,strong) UIButton *heading1Item;
@property (nonatomic,strong) UIButton *heading2Item;
@property (nonatomic,strong) UIButton *heading3Item;


- (void)updateFontBarWithButtonName:(NSString *)name;
@end

