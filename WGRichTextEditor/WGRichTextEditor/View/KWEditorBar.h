//
//  KWEditorBar.h
//  KaiWen
//
//  Created by 胡文广 on 2017/12/27.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import <UIKit/UIKit.h>

//底部编辑栏高度
#define KWEditorBar_Height 44

@class KWEditorBar;
@protocol KWEditorBarDelegate<NSObject>
- (void)editorBar:(KWEditorBar *)editorBar didClickIndex:(NSInteger)buttonIndex;
@end
@interface KWEditorBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *keyboardButton;

@property (weak, nonatomic) IBOutlet UIButton *undoButton;

@property (weak, nonatomic) IBOutlet UIButton *redoButton;

@property (weak, nonatomic) IBOutlet UIButton *fontButton;

@property (weak, nonatomic) IBOutlet UIButton *linkButton;

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

+ (instancetype)editorBar;

@property (nonatomic,weak) id<KWEditorBarDelegate> delegate;


@end
