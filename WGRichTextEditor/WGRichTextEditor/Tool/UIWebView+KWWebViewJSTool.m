//
//  UIWebView+KWWebViewJSTool.m
//  KaiWen
//
//  Created by 胡文广 on 2017/11/16.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import "UIWebView+KWWebViewJSTool.h"

@implementation UIWebView (KWWebViewJSTool)
#pragma mark 标题、内容
//- (NSString *)getHTML{
//    
//    NSString *html = [self contentHtmlText];
//    html = [self removeQuotesFromHTML:html];
//    html = [self tidyHTML:html];
//    return html;
//    
//}
- (NSString *)contentHtmlText{
    return  [self stringByEvaluatingJavaScriptFromString:@"RE.getHtml();"];
}
- (NSString *)titleText{
    return  [self stringByEvaluatingJavaScriptFromString:@"RE.getTitle();"];
}
- (void)setupTitle:(NSString *)title{
    NSString *trigger = [NSString stringWithFormat:@"RE.setTitle(\"%@\");",title];
    [self stringByEvaluatingJavaScriptFromString:trigger];
}

- (NSString *)contentText{
    NSString *contentStr = [self stringByEvaluatingJavaScriptFromString:@"RE.getText();"];
    return  [contentStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
}

- (void)setupContent:(NSString *)content{
    NSString *html = [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *trigger = [NSString stringWithFormat:@"RE.setHtml(\"%@\");",html];
    
    [self stringByEvaluatingJavaScriptFromString:trigger];
}


- (void)clearContentPlaceholder{
    [self stringByEvaluatingJavaScriptFromString:@"RE.clearBackTxt();"];
}

- (void)showContentPlaceholder{
    [self stringByEvaluatingJavaScriptFromString:@"RE.showBackTxt();"];
}

#pragma mark - Utilities

- (NSString *)removeQuotesFromHTML:(NSString *)html {
    html = [html stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    html = [html stringByReplacingOccurrencesOfString:@"“" withString:@"&quot;"];
    html = [html stringByReplacingOccurrencesOfString:@"”" withString:@"&quot;"];
    html = [html stringByReplacingOccurrencesOfString:@"\r"  withString:@"\\r"];
    html = [html stringByReplacingOccurrencesOfString:@"\n"  withString:@"\\n"];
    return html;
}


- (NSString *)tidyHTML:(NSString *)html {
    html = [html stringByReplacingOccurrencesOfString:@"<br>" withString:@"<br />"];
    html = [html stringByReplacingOccurrencesOfString:@"<hr>" withString:@"<hr />"];
    
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"style_html(\"%@\");", html]];
}

- (void)undo{
    [self stringByEvaluatingJavaScriptFromString:@"RE.undo();"];
}

- (void)redo{
    [self stringByEvaluatingJavaScriptFromString:@"RE.redo();"];
}
- (void)bold{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setBold();"];
}
- (void)italic{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setItalic();"];
}
- (void)underline{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setUnderline();"];
}
- (void)justifyLeft{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setJustifyLeft();"];
}

- (void)justifyCenter{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setJustifyCenter();"];
}

- (void)justifyRight{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setJustifyRight();"];
}
- (void)blockQuote{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setBlockquote();"];
    
}
- (void)indent{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setIndent();"];
}

- (void)outdent{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setOutdent();"];
}
- (void)unorderlist{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setBullets();"];
}
- (void)orderlist{
    [self stringByEvaluatingJavaScriptFromString:@"RE.setNumbers();"];
}

- (void)insertLinkUrl:(NSString *)url title:(NSString*)title content:(NSString *)content{
    NSString *trigger= [NSString stringWithFormat:@"RE.insertLink(\"%@\", \"%@\",\"%@\",);",url,title,content];
    
    [self stringByEvaluatingJavaScriptFromString:trigger];

}
- (void)heading1 {
    [self stringByEvaluatingJavaScriptFromString:@"RE.setHeading('1');"];
}

- (void)heading2 {
    [self stringByEvaluatingJavaScriptFromString: @"RE.setHeading('2');"];
}

- (void)heading3 {
    [self stringByEvaluatingJavaScriptFromString:@"RE.setHeading('3');"];
}

//唤醒键盘
- (void)focusTextEditor{
    self.keyboardDisplayRequiresUserAction = NO;
    [self stringByEvaluatingJavaScriptFromString:@"RE.focusEditor();"];
}

- (void)normalFontSize{
    NSString *trigger = [NSString stringWithFormat:@"RE.setFontSize(\"%@\");", @"3"];
    [self stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)insertImageUrl:(NSString *)imageUrl alt:(NSString *)alt {
    NSString *trigger = [NSString stringWithFormat:@"RE.insertImage(\"%@\", \"%@\");", imageUrl, alt];
    
    [self stringByEvaluatingJavaScriptFromString:trigger];
}

- (NSString *)getSelectString{
    return  [self stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
}

- (NSString *)getSelection{
    NSString *tagName = [self stringByEvaluatingJavaScriptFromString:@"window.getSelection().anchorNode.parentNode.tagName.toString()"];
    return [tagName stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (void)clearLink{
      [self stringByEvaluatingJavaScriptFromString:@"RE.clearLink();"];
//    [self showKeyboardContent];
}

- (void)showKeyboardTitle{
    self.keyboardDisplayRequiresUserAction = NO;
    [self stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"article_title\").focus()"];
}

- (void)showKeyboardContent{
    self.keyboardDisplayRequiresUserAction = NO;
    [self stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"article_content\").focus()"];
}

//退出键盘
- (void)hiddenKeyboard{
    [self stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
}

- (CGFloat)getCaretYPosition{
    //    [self stringByEvaluatingJavaScriptFromString:@"RE.calculateEditorHeightWithCaretPosition()"];
    
    return [[self stringByEvaluatingJavaScriptFromString:@"RE.getCaretYPosition();"] floatValue];
}
- (void)autoScrollTop:(CGFloat)offsetY{
    NSString *str = [NSString stringWithFormat:@"RE.autoScroll(\"%f\");",offsetY];
    
    [self stringByEvaluatingJavaScriptFromString:str];
}

- (void)setFontSize:(NSString *)size{
    NSString *trigger = [NSString stringWithFormat:@"RE.setFontSize(\"%@\");", size];
    [self stringByEvaluatingJavaScriptFromString:trigger];
}

//插入编码图片
- (void)inserImage:(NSData *)imageData key:(NSString *)key{
    //    NSData *scaledImageData = UIImageJPEGRepresentation(image, 1);
    NSString *imageBase64String = [imageData base64EncodedStringWithOptions:0];
    NSString *trigger = [NSString stringWithFormat:@"RE.insertImageBase64String(\"%@\", \"%@\");",imageBase64String,key];
    [self stringByEvaluatingJavaScriptFromString:trigger];
    
}

//图片上传中
- (void)inserImageKey:(NSString *)imageKey progress:(CGFloat)progress{
    NSString *trigger = [NSString stringWithFormat:@"RE.uploadImg(\"%@\", \"%.2f\");",imageKey, progress];
    [self stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)inserSuccessImageKey:(NSString *)imageKey imgUrl:(NSString *)imgUrl{
    NSString *trigger = [NSString stringWithFormat:@"RE.insertSuccessReplaceImg(\"%@\", \"%@\");",imageKey, imgUrl];
    [self stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)deleteImageKey:(NSString *)key{
    NSString *trigger = [NSString stringWithFormat:@"RE.removeImg(\"%@\");",key];
    [self stringByEvaluatingJavaScriptFromString:trigger];
    
    //可编辑
    [self stringByEvaluatingJavaScriptFromString:@"RE.canFocus(true);"];
}

- (void)setupContentDisable:(BOOL)disable{
    NSString *trigger = [NSString stringWithFormat:@"RE.canFocus(\"%@\");",disable?@"true":@"false"];
    [self stringByEvaluatingJavaScriptFromString:trigger];
    
    [self stringByEvaluatingJavaScriptFromString:@"RE.restorerange();"];
}

- (void)uploadErrorKey:(NSString *)key{
    NSString *trigger = [NSString stringWithFormat:@"RE.uploadError(\"%@\");",key];
    [self stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)removeBtnErrorKey:(NSString *)key isHide:(BOOL)isHide{
    NSString *trigger = [NSString stringWithFormat:@"RE.removeErrorBtn(\"%@\",\"%@\");",key,isHide?@"true":@"false"];
    [self stringByEvaluatingJavaScriptFromString:trigger];
}

@end



@implementation NSString (UUID)
+ (NSString *)uuid {
    CFUUIDRef uuidRef = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, uuidRef);
    NSString *uuid = (__bridge NSString *)uuidString;
    CFRelease(uuidString);
    CFRelease(uuidRef);
    
    return uuid;
}

-(id)jsonObject{
    NSError *error = nil;
    if (!self) {
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    if (error || [NSJSONSerialization isValidJSONObject:result] == NO){
        return nil;
    }
    return result;
}
-(NSString*)stringByAppendingUrlComponent:(NSString*)string{
    NSString* urlhost = [self toTrim];
    if([string isBeginWith:@"/"]){
        if([urlhost isEndWith:@"/"]){
            urlhost = [urlhost substringToIndex:urlhost.length - 1];
        }
    }else{
        if([urlhost isEndWith:@"/"] == NO){
            urlhost = [urlhost stringByAppendingString:@"/"];
        }
    }
    return [urlhost stringByAppendingString:string];
}
-(BOOL)isBeginWith:(NSString *)string{
    return ([self hasPrefix:string]) ? YES : NO;
}
-(BOOL)isEndWith:(NSString *)string{
    return ([self hasSuffix:string]) ? YES : NO;
}
-(NSString*)toTrim{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}
@end
