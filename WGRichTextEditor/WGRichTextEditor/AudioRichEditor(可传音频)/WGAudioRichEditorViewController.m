//
//  WGAudioRichEditorViewController.m
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/1.
//  Copyright © 2019 wenguang. All rights reserved.
//

#import "WGAudioRichEditorViewController.h"

@interface WGAudioRichEditorViewController ()
@property (nonatomic,strong) WGEditorToolBar *toolBarView;
@end

@implementation WGAudioRichEditorViewController
- (WGEditorToolBar *)toolBarView{
    if (_toolBarView == nil) {
        CGFloat toolBarH = IS_IPhoneX_All?50:KWEditorBar_Height;
        _toolBarView = [[WGEditorToolBar alloc] initToolBarStyle:WGEditorToolBarStyleAudio withFrame:CGRectMake(0,WG_SCREEN_HEIGHT - toolBarH - WG_SafeAreaTopHeight, self.view.width, toolBarH)];
    }
    return _toolBarView;
}
- (void)viewDidLoad {
    self.webHTML = @"RichEditor.html";
    self.toolBar = self.toolBarView;
    
    [super viewDidLoad];
}
///MARK:WKWebViewDeleate
- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    [super webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [super webView:webView didFinishNavigation:navigation];
    
}
- (void)audioAction{
    
    [SVProgressHUD showErrorWithStatus:@"音频排期中"];
    
}
@end
