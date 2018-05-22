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
// 向里缩进
- (void)indent;
// 向外缩进
- (void)outdent;

- (void)blockQuote;

- (void)orderlist;
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

- (CGFloat)getCaretYPosition;
- (void)autoScrollTop:(CGFloat)offsetY;

- (void)setFontSize:(NSString *)size;


//开始插入图片
- (void)inserImage:(NSData *)imageData key:(NSString *)key;
//图片上传中更新进度条
- (void)inserImageKey:(NSString *)imageKey progress:(CGFloat)progress;
//图片上传成功 替换img标签
- (void)inserSuccessImageKey:(NSString *)imageKey imgUrl:(NSString *)imgUrl;
//删除图片
- (void)deleteImageKey:(NSString *)key;

//设置编辑器内容是否可编辑(解决弹出键盘问题)
- (void)setupContentDisable:(BOOL)disable;

// 上传失败
- (void)uploadErrorKey:(NSString *)key;
- (void)removeBtnErrorKey:(NSString *)key isHide:(BOOL)isHide;
@end

@interface NSString (UUID)

+ (NSString *)uuid;
- (id)jsonObject;
- (NSString*)removeSubstring:(NSString *)subString;

@end
