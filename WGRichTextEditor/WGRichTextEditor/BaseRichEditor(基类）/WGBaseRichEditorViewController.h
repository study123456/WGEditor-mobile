//
//  WGBaseRichEditorViewController.h
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/1.
//  Copyright © 2019 wenguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface WGBaseRichEditorViewController : UIViewController
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,copy) NSString *webHTML;
@property (nonatomic,strong) WGEditorToolBar *toolBar;
@property (nonatomic,assign) CGFloat keboardHeight;
///MARK:WKWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler;
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error;
//判断图片是否都上传成功
- (BOOL)isUploadResult;
- (void)videoAction;
- (void)audioAction;
- (void)settingAction;
@end

NS_ASSUME_NONNULL_END
