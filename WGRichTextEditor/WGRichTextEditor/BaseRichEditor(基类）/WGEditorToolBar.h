//
//  WGEditorToolBar.h
//  KaiWen
//
//  Created by 胡文广 on 2019/8/15.
//  Copyright © 2019 胡文广. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    WGEditorToolBarActionDefault = 0,
    WGEditorToolBarActionPhoto = 1,
    WGEditorToolBarActionVideo = 2,
    WGEditorToolBarActionAudio = 3,
    WGEditorToolBarActionFont = 4,
    WGEditorToolBarActionUndo = 5,
    WGEditorToolBarActionRedo = 6,
    WGEditorToolBarActionSetting = 7,
    WGEditorToolBarActionLink = 8,
} WGEditorToolBarAction;

typedef enum : NSUInteger {
    WGEditorToolBarStyleNoneBasic = 0,
    WGEditorToolBarStyleFull = 1,
    WGEditorToolBarStyleVideo = 2, //只有视频按钮
    WGEditorToolBarStyleAudio = 3, //只有音频按钮
    WGEditorToolBarStyleSetting = 4, //只有最后一个设置按钮
} WGEditorToolBarStyle;
@class WGEditorToolBar;
@protocol WGEditorToolBarDelegate
-(void)editorToolBar:(WGEditorToolBar *)toolBar clickBtn:(WGEditorToolBarAction)toolBarAction;
@end

#define KWEditorBar_Height 44

@interface WGEditorToolBar : UIView{
    
    WGEditorToolBarAction _toolBarAction;
    
    WGEditorToolBarStyle _toolBarStyle;
}
@property (nonatomic,strong) UIButton *settingItem;
@property (nonatomic,assign) id<WGEditorToolBarDelegate> delegate;
-(instancetype)initToolBarStyle:(WGEditorToolBarStyle)style withFrame:(CGRect)frame;

@property (nonatomic,assign) BOOL fontSelected;

@property (nonatomic,assign) BOOL keyBoardSelected;

@end

NS_ASSUME_NONNULL_END
