//
//  KWEditorBar.m
//  KaiWen
//
//  Created by 胡文广 on 2017/12/27.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import "KWEditorBar.h"
#define COLOR(r,g,b,a) ([UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a])
@interface KWEditorBar()
@property (nonatomic,strong) CALayer *topline;
@end
@implementation KWEditorBar

- (CALayer *)topline{
    if (_topline) {
        CALayer *border = [CALayer layer];
        border.backgroundColor = COLOR(216,216,216,1).CGColor;
        
        border.frame = CGRectMake(14, 0, self.frame.size.width, 1);

    }
    return _topline;
}


+ (instancetype)editorBar{
    return [[NSBundle mainBundle] loadNibNamed:@"KWEditorBar" owner:nil options:nil][0];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    

}
- (IBAction)clickKeyboard:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        [self.delegate editorBar:self didClickIndex:0];
    }
}
- (IBAction)clickUndo:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        [self.delegate editorBar:self didClickIndex:1];
    }
}
- (IBAction)clickRedo:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        
        [self.delegate editorBar:self didClickIndex:2];
    }
}
- (IBAction)clickfont:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        
        [self.delegate editorBar:self didClickIndex:3];
    }
}
- (IBAction)clickLink:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        [self.delegate editorBar:self didClickIndex:4];
    }
}
- (IBAction)clickImg:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        [self.delegate editorBar:self didClickIndex:5];
    }
}

@end
