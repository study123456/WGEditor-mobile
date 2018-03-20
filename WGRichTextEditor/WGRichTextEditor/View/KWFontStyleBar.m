//
//  KWFontStyleBar.m
//  KaiWen
//
//  Created by 胡文广 on 2017/12/27.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import "KWFontStyleBar.h"
#import "UIControl+KWButtonExtension.h"
//最右边按钮宽度
#define KWRightButton_Width 44

//所有按钮宽度
#define KWItems_Width 46

#define COLOR(r,g,b,a) ([UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a])
@interface KWFontStyleBar()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scroBarView;
@property (nonatomic,strong) UIButton *autoScroBtn;
@property (nonatomic,strong) NSArray *items;

@end
@implementation KWFontStyleBar

- (UIScrollView *)scroBarView{
    if (!_scroBarView) {
        _scroBarView = [[UIScrollView alloc] init];
        _scroBarView.backgroundColor = COLOR(237, 237, 237, 1);
        _scroBarView.delegate = self;
        _scroBarView.showsVerticalScrollIndicator = NO;
        _scroBarView.showsHorizontalScrollIndicator = NO;
    }
    return _scroBarView;
}
- (UIButton *)autoScroBtn{
    if (!_autoScroBtn) {
        _autoScroBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_autoScroBtn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
        [_autoScroBtn setImage:[UIImage imageNamed:@"icon_left"] forState:UIControlStateSelected];
         [_autoScroBtn setAdjustsImageWhenHighlighted:NO];
        
        [_autoScroBtn addTarget:self action:@selector(autoScrollView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _autoScroBtn;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews:frame];
    }
    return self;
}



- (void)setupViews:(CGRect)frame{

    self.scroBarView.frame = CGRectMake(0,0, frame.size.width - KWRightButton_Width, KWFontBar_Height);
    
    self.autoScroBtn.frame = CGRectMake(frame.size.width - KWRightButton_Width, 0, KWRightButton_Width, KWFontBar_Height);
    
    [self addSubview:self.scroBarView];
    [self addSubview:self.autoScroBtn];
    
    self.items = @[
                   self.boldItem,
                  self.underlineItem,
                  self.italicItem,
                   self.heading3Item,
                   self.heading2Item,
                   self.heading1Item,
                  self.justifyLeftItem,
                  self.justifyCenterItem,
                  self.justifyRightItem,
                   self.unorderlistItem,
                  self.indentItem,
//                  self.outdentItem,
                ];
    
    NSInteger itemsCount = self.items.count;
//    CGFloat itemW = (self.scroBarView.frame.size.width - KViewHeight) / itemsCount;
    for (int i = 0; i < itemsCount; i++) {
        UIButton *button = self.items[i];
        button.frame = CGRectMake(i*KWItems_Width,0, KWItems_Width,frame.size.height);
        button.tag = i;
        [self.scroBarView addSubview:button];

    }
    self.scroBarView.contentSize = CGSizeMake(itemsCount*KWItems_Width, 0);
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark -items
- (void)clickButton:(UIButton *)button{
    //处理字体大小样式
    if (button == self.heading1Item && self.heading1Item.selected) {
        button.selected = !button.selected;
        
        self.heading2Item.selected = NO;
        self.heading3Item.selected = NO;

        //恢复默认字体
        if (!self.heading1Item.selected && !self.heading2Item.selected && !self.heading3Item.selected) {

            if ([self.delegate respondsToSelector:@selector(fontBarResetNormalFontSize)]) {
                [self.delegate fontBarResetNormalFontSize];
            }
        }

    }else if (button == self.heading2Item && self.heading2Item.selected){
        button.selected = !button.selected;
        
        self.heading1Item.selected = NO;
        self.heading3Item.selected = NO;
        //恢复默认字体
        if (!self.heading1Item.selected && !self.heading2Item.selected && !self.heading3Item.selected) {

            if ([self.delegate respondsToSelector:@selector(fontBarResetNormalFontSize)]) {
                [self.delegate fontBarResetNormalFontSize];
            }
        }
    }else if (button == self.heading3Item && self.heading3Item.selected){
        button.selected = !button.selected;
        self.heading1Item.selected = NO;
        self.heading2Item.selected = NO;
        //恢复默认字体
        if (!self.heading1Item.selected && !self.heading2Item.selected && !self.heading3Item.selected) {

            if ([self.delegate respondsToSelector:@selector(fontBarResetNormalFontSize)]) {
                [self.delegate fontBarResetNormalFontSize];
            }
        }
    }
    
    
    if ([self.delegate respondsToSelector:@selector(fontBar:didClickBtn:)]) {
        [self.delegate fontBar:self didClickBtn:button];
    }
}
- (UIButton *)boldItem{
    if (!_boldItem) {
        _boldItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_boldItem setImage:[UIImage imageNamed:@"B"] forState:UIControlStateNormal];
        [_boldItem setImage:[UIImage imageNamed:@"BHOVER"] forState:UIControlStateSelected];
        _boldItem.orderTag = @"bold";
        [_boldItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boldItem;
}
- (UIButton *)underlineItem{
    if (!_underlineItem) {
        _underlineItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_underlineItem setImage:[UIImage imageNamed:@"u"] forState:UIControlStateNormal];
        _underlineItem.orderTag = @"underline";
        [_underlineItem setImage:[UIImage imageNamed:@"uHOVER"] forState:UIControlStateSelected];
        [_underlineItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _underlineItem;
}

- (UIButton *)italicItem{
    if (!_italicItem) {
        _italicItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_italicItem setImage:[UIImage imageNamed:@"I"] forState:UIControlStateNormal];
        [_italicItem setImage:[UIImage imageNamed:@"IHOVER"] forState:UIControlStateSelected];
        _italicItem.orderTag = @"italic";
        [_italicItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _italicItem;
}

- (UIButton *)justifyLeftItem{
    if (!_justifyLeftItem) {
        _justifyLeftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_justifyLeftItem setImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
       [_justifyLeftItem setImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateSelected];
        _justifyLeftItem.orderTag = @"justifyLeft";
        [_justifyLeftItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _justifyLeftItem;
}

- (UIButton *)justifyCenterItem{
    if (!_justifyCenterItem) {
        _justifyCenterItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_justifyCenterItem setImage:[UIImage imageNamed:@"zhong"] forState:UIControlStateNormal];
         [_justifyCenterItem setImage:[UIImage imageNamed:@"zhong"] forState:UIControlStateSelected];
        _justifyCenterItem.orderTag = @"justifyCenter";
                [_justifyCenterItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _justifyCenterItem;
}

- (UIButton *)justifyRightItem{
    if (!_justifyRightItem) {
        _justifyRightItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_justifyRightItem setImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
        [_justifyRightItem setImage:[UIImage imageNamed:@"you"] forState:UIControlStateSelected];
        _justifyRightItem.orderTag = @"justifyRight";
            [_justifyRightItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _justifyRightItem;
}

- (UIButton *)indentItem{
    if (!_indentItem) {
        _indentItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_indentItem setImage:[UIImage imageNamed:@"suojin"] forState:UIControlStateNormal];
        [_indentItem setImage:[UIImage imageNamed:@"tool_tab"] forState:UIControlStateSelected];
//         _indentItem.orderTag = @"blockquote";
            [_indentItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _indentItem;
}

- (UIButton *)outdentItem{
    if (!_outdentItem) {
        _outdentItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_outdentItem setImage:[UIImage imageNamed:@"suojin"] forState:UIControlStateNormal];
        [_outdentItem setImage:[UIImage imageNamed:@"tool_tab"] forState:UIControlStateSelected];
//        _outdentItem.orderTag = @"blockquote";
        [_outdentItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _outdentItem;
}

- (UIButton *)unorderlistItem{
    if (!_unorderlistItem) {
        _unorderlistItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unorderlistItem setImage:[UIImage imageNamed:@"wuxuliebiao"] forState:UIControlStateNormal];
             [_unorderlistItem setImage:[UIImage imageNamed:@"wuxuliebiaohover"] forState:UIControlStateSelected];
        _unorderlistItem.orderTag = @"unorderedList";
            [_unorderlistItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unorderlistItem;
}

- (UIButton *)heading1Item{
    if (!_heading1Item) {
        _heading1Item = [UIButton buttonWithType:UIButtonTypeCustom];
        [_heading1Item setImage:[UIImage imageNamed:@"Aal"] forState:UIControlStateNormal];
        [_heading1Item setImage:[UIImage imageNamed:@"Aalhover"] forState:UIControlStateSelected];
        _heading1Item.orderTag = @"4";
        [_heading1Item addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heading1Item;
}

- (UIButton *)heading2Item{
    if (!_heading2Item) {
        _heading2Item = [UIButton buttonWithType:UIButtonTypeCustom];
        [_heading2Item setImage:[UIImage imageNamed:@"Aam"] forState:UIControlStateNormal];
        [_heading2Item setImage:[UIImage imageNamed:@"Aamhover"] forState:UIControlStateSelected];
        _heading2Item.orderTag = @"3";
        [_heading2Item addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heading2Item;
}
- (UIButton *)heading3Item{
    if (!_heading3Item) {
        _heading3Item = [UIButton buttonWithType:UIButtonTypeCustom];
        [_heading3Item setImage:[UIImage imageNamed:@"Aas"] forState:UIControlStateNormal];
        [_heading3Item setImage:[UIImage imageNamed:@"Aashover"] forState:UIControlStateSelected];
        _heading3Item.orderTag = @"2";
        [_heading3Item addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heading3Item;
}

- (void)autoScrollView{
    self.autoScroBtn.selected = !self.autoScroBtn.selected;
    if (self.autoScroBtn.selected) {
        [self.scroBarView setContentOffset:CGPointMake(self.scroBarView.contentSize.width - self.scroBarView.frame.size.width, 0) animated:YES];
    }else{
        [self.scroBarView setContentOffset:CGPointZero animated:NO];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scroBarView.contentOffset.x + scrollView.frame.size.width  >= scrollView.contentSize.width) {
        self.autoScroBtn.selected = YES;
    }else{
        self.autoScroBtn.selected = NO;
    }
}


- (void)updateFontBarWithButtonName:(NSString *)name{
    NSArray *itemNames = [name componentsSeparatedByString:@","];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSString *orderTag in itemNames) {
            for (UIButton *btn in self.items) {
                if (![tempArr containsObject:btn] && btn.orderTag.length > 0) {
                    if ([btn.orderTag isEqualToString:orderTag]) {
                        btn.selected = YES;
                         [tempArr addObject:btn];
                    }
                    else{
                        btn.selected = NO;
                    }
                }
            }
    }
    
    
    if (!self.heading1Item.selected && !self.heading2Item.selected && !self.heading3Item.selected) {
        self.heading2Item.selected = YES;
    }
    
}
@end
