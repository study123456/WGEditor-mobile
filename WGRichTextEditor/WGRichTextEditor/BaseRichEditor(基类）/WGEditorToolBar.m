//
//  WGEditorToolBar.m
//  KaiWen
//
//  Created by 胡文广 on 2019/8/15.
//  Copyright © 2019 胡文广. All rights reserved.
//

#import "WGEditorToolBar.h"
@interface WGEditorToolBar()
@property (nonatomic,strong) UIButton *keyboardItem;
@property (nonatomic,strong) UIButton *photoItem;
@property (nonatomic,strong) UIButton *videoItem;
@property (nonatomic,strong) UIButton *audioItem;
@property (nonatomic,strong) UIButton *fontItem;
@property (nonatomic,strong) UIButton *undoItem;
@property (nonatomic,strong) UIButton *redoItem;
@property (nonatomic,strong) UIButton *linkItem;
@property (nonatomic,strong) NSMutableArray *masonryViewArray;

@property (nonatomic,strong) UIImageView *topLineView;
@end
@implementation WGEditorToolBar
- (UIImageView *)topLineView{
    if (!_topLineView) {
        _topLineView = [UIImageView new];
        _topLineView.backgroundColor = WGtabBarLineColor;
    }
    return _topLineView;
}
- (NSMutableArray *)masonryViewArray {
    if (!_masonryViewArray) {
        _masonryViewArray = [NSMutableArray array];
    }
    return _masonryViewArray;
}

- (UIButton *)keyboardItem{
    if (!_keyboardItem) {
        _keyboardItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_keyboardItem setImage:[UIImage imageNamed:@"jianpanshang"] forState:UIControlStateNormal];
        [_keyboardItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keyboardItem;
}
- (UIButton *)photoItem{
    if (!_photoItem) {
        _photoItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoItem setImage:[UIImage imageNamed:@"tupian"] forState:UIControlStateNormal];
        _photoItem.tag = 1;
    [_photoItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _photoItem;
}
- (UIButton *)linkItem{
    if (!_linkItem) {
        _linkItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_linkItem setImage:[UIImage imageNamed:@"lianjie"] forState:UIControlStateNormal];
        _linkItem.tag = 8;
        [_linkItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkItem;
}
- (UIButton *)videoItem{
    if (!_videoItem) {
        _videoItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoItem setImage:[UIImage imageNamed:@"icon_video"] forState:UIControlStateNormal];
        _videoItem.tag = 2;
          [_videoItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoItem;
}
- (UIButton *)audioItem{
    if (!_audioItem) {
        _audioItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_audioItem setImage:[UIImage imageNamed:@"icon_audio"] forState:UIControlStateNormal];
        _audioItem.tag = 3;
         [_audioItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _audioItem;
}
- (UIButton *)fontItem{
    if (!_fontItem) {
        _fontItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontItem setImage:[UIImage imageNamed:@"ziti"] forState:UIControlStateNormal];
         [_fontItem setImage:[UIImage imageNamed:@"ziti_hover"] forState:UIControlStateSelected];
         _fontItem.tag = 4;
         [_fontItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fontItem;
}
- (UIButton *)undoItem{
    if (!_undoItem) {
        _undoItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_undoItem setImage:[UIImage imageNamed:@"chexiao"] forState:UIControlStateNormal];
        _undoItem.tag = 5;
         [_undoItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _undoItem;
}
- (UIButton *)redoItem{
    if (!_redoItem) {
        _redoItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_redoItem setImage:[UIImage imageNamed:@"chongzuo"] forState:UIControlStateNormal];
        _redoItem.tag = 6;
         [_redoItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _redoItem;
}
- (UIButton *)settingItem{
    if (!_settingItem) {
        _settingItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingItem setImage:[UIImage imageNamed:@"icon_shezhi"] forState:UIControlStateNormal];
        _settingItem.tag = 7;
          [_settingItem addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingItem;
}
- (void)clickToolBarBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            _toolBarAction = WGEditorToolBarActionDefault;
            break;
        case 1:
            _toolBarAction = WGEditorToolBarActionPhoto;
            break;
        case 2:
            _toolBarAction = WGEditorToolBarActionVideo;
            break;
        case 3:
            _toolBarAction = WGEditorToolBarActionAudio;
            break;
        case 4:
            _toolBarAction = WGEditorToolBarActionFont;
            break;
        case 5:
            _toolBarAction = WGEditorToolBarActionUndo;
            break;
        case 6:
            _toolBarAction = WGEditorToolBarActionRedo;
            break;
        case 7:
            _toolBarAction = WGEditorToolBarActionSetting;
            break;
        case 8:
            _toolBarAction = WGEditorToolBarActionLink;
            break;
        default:
            break;
    }
    
    [_delegate editorToolBar:self clickBtn:_toolBarAction];
}
- (void)setFontSelected:(BOOL)fontSelected{
    
    _fontSelected = fontSelected;
    
    self.fontItem.selected = fontSelected;
    
}
- (instancetype)initToolBarStyle:(WGEditorToolBarStyle)style withFrame:(CGRect)frame{
   
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = WG_WHITE;
        
        [self.masonryViewArray addObject:self.keyboardItem];
        [self.masonryViewArray addObject:self.photoItem];
        
        if (style == WGEditorToolBarStyleNoneBasic) {
            [self.masonryViewArray addObject:self.fontItem];
            [self.masonryViewArray addObject:self.undoItem];
            [self.masonryViewArray addObject:self.redoItem];
            [self.masonryViewArray addObject:self.linkItem];
        }else{
            if (style == WGEditorToolBarStyleFull) {
                [self.masonryViewArray addObject:self.videoItem];
                [self.masonryViewArray addObject:self.audioItem];
                
            }else if (style == WGEditorToolBarStyleVideo){
                [self.masonryViewArray addObject:self.videoItem];
                
            }else if (style == WGEditorToolBarStyleAudio){
                [self.masonryViewArray addObject:self.audioItem];
            }else if (style == WGEditorToolBarStyleSetting){
               
            }
            
            [self.masonryViewArray addObject:self.fontItem];
            [self.masonryViewArray addObject:self.undoItem];
            [self.masonryViewArray addObject:self.redoItem];
            [self.masonryViewArray addObject:self.settingItem];
        }
    
     [self makeEqualWidthViews:self.masonryViewArray inView:self LRpadding:0 viewPadding:0 viewBottom:0];
        
      
        [self addSubview:self.topLineView];
   
        [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self);
            make.height.mas_offset(0.5);
        }];
    }
    return self;
}



-(void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding  viewBottom :(CGFloat)viewBottom
{
    UIView *lastView;
    for (UIView *view in views) {
        [containerView addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(containerView);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
                make.bottom.equalTo(containerView.mas_bottom).offset(viewBottom);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView).offset(LRpadding);
                make.top.equalTo(containerView);
                make.bottom.equalTo(containerView.mas_bottom).offset(viewBottom);
            }];
        }
        lastView=view;
    }
    
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(containerView).offset(-LRpadding);
        
    }];
}
@end
