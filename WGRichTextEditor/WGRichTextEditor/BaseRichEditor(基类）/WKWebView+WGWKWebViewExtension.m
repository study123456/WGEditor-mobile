//
//  WKWebView+WGWKWebViewExtension.m
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/1.
//  Copyright © 2019 wenguang. All rights reserved.
//

#import "WKWebView+WGWKWebViewExtension.h"
#import <objc/runtime.h>
@implementation WKWebView (WGWKWebViewExtension)
- (void)evaluateJavaScriptRelust:(NSString *)jsAction
                              Callback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback{
    [self evaluateJavaScript:jsAction completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"ERROR = %@",error);
        if (callback) {
            callback(obj,error);
        }
    }];
}
- (void)titleTextHandleCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback{
    [self evaluateJavaScriptRelust:@"RE.getTitle();" Callback:callback];
}
- (void)contentHtmlTextHandleCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback{
     [self evaluateJavaScriptRelust:@"RE.getHtml();" Callback:callback];
}
- (void)contentTextHandleCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback{
    [self evaluateJavaScriptRelust:@"RE.getText();" Callback:^(id  _Nullable obj, NSError * _Nullable error) {
        if (error == nil) {
            NSString *contentText = obj;
            //去掉首尾换行符
             contentText = [contentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if (callback) {
                callback(contentText,nil);
            }
        }else{
            if (callback) {
                callback(nil,error);
            }
        }
    }];
}
- (void)setupTitle:(NSString *)title{
    NSString *text = [title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *jsString = [NSString stringWithFormat:@"RE.setTitle(\'%@\');",text];
    [self evaluateJavaScriptRelust:jsString Callback:nil];
}
- (void)setupContent:(NSString *)content{
    NSString *text = [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *jsString = [NSString stringWithFormat:@"RE.setHtml(\'%@\');",text];
    [self evaluateJavaScriptRelust:jsString Callback:nil];
}
- (void)placeHolderWithHidden:(BOOL)isHidden{
    NSString *trigger = [NSString
                         stringWithFormat:isHidden?@"RE.clearBackTxt();":@"RE.showBackTxt();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}

- (void)updatePlaceHolderStatu{
    [self contentTextHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        BOOL hiddenPlaceHolder = FALSE;
        if (error == nil) {
            NSString *contentText = obj;
            hiddenPlaceHolder = contentText.length;
            [self placeHolderWithHidden:hiddenPlaceHolder];
        }
        
        if (hiddenPlaceHolder == FALSE) {
            [self contentHtmlTextHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
                if (error == nil) {
                    NSString *contentHtmlString = obj;
                    BOOL hiddenPlaceHolder = [self getImgTags:contentHtmlString].count > 0;
                    [self placeHolderWithHidden:hiddenPlaceHolder];
                }
            }];
        }
    }];
}

- (void)undo{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.undo();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}

- (void)redo{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.redo();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)bold{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setBold();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)italic{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setItalic();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)underline{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setUnderline();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)justifyLeft{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setJustifyLeft();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}

- (void)justifyCenter{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setJustifyCenter();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}

- (void)justifyRight{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setJustifyRight();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}

- (void)indent{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setIndent();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)outdent{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setOutdent();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)unorderlist{
    NSString *trigger = [NSString
                         stringWithFormat:@"RE.setBullets();"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)heading1 {
    NSString *trigger = @"RE.setHeading('1');";
     [self evaluateJavaScriptRelust:trigger Callback:nil];
    
}
- (void)heading2 {
    NSString *trigger = @"RE.setHeading('2');";
     [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)heading3 {
    NSString *trigger = @"RE.setHeading('3');";
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)normalFontSize{
    NSString *trigger = [NSString stringWithFormat:@"RE.setFontSize(\'%@\');", @"3"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)insertImageUrl:(NSString *)imageUrl alt:(NSString *)alt {
    NSString *trigger = [NSString stringWithFormat:@"RE.insertImage(\'%@\', \'%@\');", imageUrl, alt];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)insertLinkUrl:(NSString *)url title:(NSString*)title content:(NSString *)content{
    NSString *trigger= [NSString
                        stringWithFormat:@"RE.insertLink(\'%@\', \'%@\',\'%@\',);",url,title,content];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)getSelectStringHandleCallback:(void (^)(id _Nullable obj, NSError *
                                                      _Nullable error))callback{
     [self evaluateJavaScriptRelust:@"window.getSelection().toString()" Callback:callback];
    
    
}
- (void)removeAllRange{
       [self evaluateJavaScriptRelust:@"RE.removeAllRanges()" Callback:nil];
}
- (void)getSelectionHandleCallback:(void (^)(id _Nullable obj, NSError *
                                                   _Nullable error))callback{
    NSString *tagName = @"window.getSelection().anchorNode.parentNode.tagName.toString()";
    [self evaluateJavaScriptRelust:tagName Callback:callback];
}
- (void)clearLink{
    [self evaluateJavaScriptRelust:@"RE.clearLink();" Callback:nil];
}
- (void)setFontSize:(NSString *)size{
    NSString *trigger = [NSString stringWithFormat:@"RE.setFontSize(\'%@\');", size];
     [self evaluateJavaScriptRelust:trigger Callback:nil];
}

- (void)titleBecomeFirstResponder{
//    self.keyboardDisplayRequiresUserAction = NO;
     [self evaluateJavaScriptRelust:@"document.getElementById(\"article_title\").focus()" Callback:nil];
}
- (void)contentBecomeFirstResponder{
    [self evaluateJavaScriptRelust:@"document.getElementById(\"article_content\").focus()" Callback:nil];
}
- (void)hiddenKeyboard{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)autoScrollTop:(CGFloat)offsetY{
    NSString *str = [NSString stringWithFormat:@"RE.autoScroll(\"%f\");",offsetY];
    
    [self evaluateJavaScriptRelust:str Callback:nil];
}
- (void)getCaretYPositionPositionHandleCallback:(void (^)(id _Nullable obj, NSError *
                                                  _Nullable error))callback{
     [self evaluateJavaScriptRelust:@"RE.getCaretYPosition();" Callback:callback];
}

- (void)insetImage:(NSData *)imageData key:(NSString *)key{
    //设置内容可编辑
    [self setupContentDisable:true];
    //唤醒键盘
    [self evaluateJavaScriptRelust:@"document.getElementById(\"article_content\").focus();" Callback:nil];
    
    NSString *imageBase64String = [imageData base64EncodedStringWithOptions:0];
    
    NSString *trigger = [NSString stringWithFormat:@"RE.insertImageBase64String(\"%@\", \"%@\");",imageBase64String,key];
    
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)setupContentDisable:(BOOL)disable{
    NSString *trigger = [NSString stringWithFormat:@"RE.canFocus(\"%@\");",disable?@"true":@"false"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
    
    [self evaluateJavaScriptRelust:@"RE.restorerange();" Callback:nil];
}
- (void)insetImageKey:(NSString *)imageKey progress:(CGFloat)progress{
    NSString *trigger = [NSString stringWithFormat:@"RE.uploadImg(\"%@\", \"%.2f\");",imageKey, progress];
    
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}

- (void)insetSuccessImageKey:(NSString *)imageKey imgUrl:(NSString *)imgUrl{
    NSString *trigger = [NSString stringWithFormat:@"RE.insertSuccessReplaceImg(\"%@\", \"%@\");",imageKey, imgUrl];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)deleteImageKey:(NSString *)key{
    [self setupContentDisable:true];
    NSString *trigger = [NSString stringWithFormat:@"RE.removeImg(\"%@\");",key];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)uploadErrorKey:(NSString *)key{
    NSString *trigger = [NSString stringWithFormat:@"RE.uploadError(\"%@\");",key];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
- (void)removeBtnErrorKey:(NSString *)key isHide:(BOOL)isHide{
    NSString *trigger = [NSString stringWithFormat:@"RE.removeErrorBtn(\"%@\",\"%@\");",key,isHide?@"true":@"false"];
    [self evaluateJavaScriptRelust:trigger Callback:nil];
}
//获取IMG标签
-(NSArray*)getImgTags:(NSString *)htmlText{
    if (htmlText == nil) {
        return nil;
    }
    NSError *error;
    NSString *regulaStr = @"<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:htmlText options:0 range:NSMakeRange(0, [htmlText length])];
    return arrayOfAllMatches;
}
@end

@implementation WKWebView (WGHideAccessoryView)
static const char * const hackishFixClassName = "UIWebBrowserViewMinusAccessoryView";
static Class hackishFixClass = Nil;
- (UIView *)hackishlyFoundBrowserView {
    UIScrollView *scrollView = self.scrollView;
    
    UIView *browserView = nil;
    for (UIView *subview in scrollView.subviews) {
        if ([NSStringFromClass([subview class]) hasPrefix:@"WKContentView"]) {
            browserView = subview;
            break;
        }
    }
    return browserView;
}

- (id)methodReturningNil {
    return nil;
}

- (void)ensureHackishSubclassExistsOfBrowserViewClass:(Class)browserViewClass {
    if (!hackishFixClass) {
        Class newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        IMP nilImp = [self methodForSelector:@selector(methodReturningNil)];
        class_addMethod(newClass, @selector(inputAccessoryView), nilImp, "@@:");
        objc_registerClassPair(newClass);
        
        hackishFixClass = newClass;
    }
}

- (BOOL) hidesInputAccessoryView {
    UIView *browserView = [self hackishlyFoundBrowserView];
    return [browserView class] == hackishFixClass;
}

- (void) setHidesInputAccessoryView:(BOOL)value {
    UIView *browserView = [self hackishlyFoundBrowserView];
    if (browserView == nil) {
        return;
    }
    [self ensureHackishSubclassExistsOfBrowserViewClass:[browserView class]];
    
    if (value) {
        object_setClass(browserView, hackishFixClass);
    }
    else {
        Class normalClass = objc_getClass("WKContentView");
        object_setClass(browserView, normalClass);
    }
    [browserView reloadInputViews];

}
@end
