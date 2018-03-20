//
//  UIWebView+KWWebViewJSTool.h
//  KaiWen
//
//  Created by 胡文广 on 2017/11/16.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (KWWebViewJSTool)
- (NSString *)titleText;

- (void)setupTitle:(NSString *)title;

- (NSString *)contentText;
- (NSString *)contentHtmlText;

- (void)setupContent:(NSString *)content;

- (void)clearContentPlaceholder;
- (void)showContentPlaceholder;
- (void)focusTextEditor;
//撤销
- (void)undo;
- (void)redo;
//加粗
- (void)bold;
//下划线
- (void)underline;
//斜体
- (void)italic;
//左对齐
- (void)justifyLeft;
//居中对齐
- (void)justifyCenter;
//右对齐
- (void)justifyRight;

- (void)indent;
- (void)outdent;

- (void)unorderlist;


- (void)heading1;
- (void)heading2;
- (void)heading3;
- (void)normalFontSize;

- (void)insertLinkUrl:(NSString *)url title:(NSString*)title content:(NSString *)content;
- (void)insertImageUrl:(NSString *)imageUrl alt:(NSString *)alt;

//获取选中内容标签值
- (NSString *)getSelection;
//获取webView选中内容
- (NSString *)getSelectString;
- (void)focus;
//清除超链接
- (void)clearLink;
//判断正文是否有内容
- (BOOL)checkContent;
//标题聚焦 - 唤醒键盘
- (void)showKeyboardTitle;
- (void)showKeyboardContent;
//退出键盘
- (void)hiddenKeyboard;

- (void)getCaretYPosition;

- (void)setFontSize:(NSString *)size;

@end
