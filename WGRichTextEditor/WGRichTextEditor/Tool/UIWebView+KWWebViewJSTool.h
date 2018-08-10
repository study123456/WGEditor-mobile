//
//  UIWebView+KWWebViewJSTool.h
//  KaiWen
//
//  Created by 胡文广 on 2017/11/16.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (KWWebViewJSTool)


/**
 *  返回标题文本
 */
- (NSString *)titleText;

/**
 *  设置标题内容
 @param title   标题内容
 */
- (void)setupTitle:(NSString *)title;

/**
 *  返回文本内容
 */
- (NSString *)contentText;

/**
 *  返回带标签的html格式的文本内容
 */
- (NSString *)contentHtmlText;


/**
 *  设置文本内容

 @param content 内容
 */
- (void)setupContent:(NSString *)content;


/**
 *  清除内容的占位文本
 */
- (void)clearContentPlaceholder;


/**
 *  显示内容的占位文本
 */
- (void)showContentPlaceholder;


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
//无序
- (void)orderlist;
- (void)unorderlist;

/**
 *  内容默认14号字体
 */
- (void)normalFontSize;

/**
 *  内容18号字体 (如需修改在normalize.css h1标签里面修改即可)
 */
- (void)heading1;

/**
 *  内容16号字体 (如需修改在normalize.css h1标签里面修改即可)
 */
- (void)heading2;

/**
 *  内容14号字体 (默认14,如需修改在normalize.css h1标签里面修改即可)
 */
- (void)heading3;

/**
 *  插入链接
 @param url     链接地址
 @param title   链接标题
 @param content 链接内容
 */
- (void)insertLinkUrl:(NSString *)url title:(NSString*)title content:(NSString *)content;

/**
 *  插入图片链接
 @param imageUrl 图片地址
 @param alt 图片标题
 */
- (void)insertImageUrl:(NSString *)imageUrl alt:(NSString *)alt;

/**
 *  清除被选中的链接内容
 */
- (void)clearLink;

/**
 *  获取被选中的内容
 */
- (NSString *)getSelection;

/**
 *  获取被选中内容标签内容
 */
- (NSString *)getSelectString;

- (CGFloat)getCaretYPosition;

//滚动到对应位置
- (void)autoScrollTop:(CGFloat)offsetY;

/**
 *  设置字体大小
 */
- (void)setFontSize:(NSString *)size;



/**
 *  插入图片
 @param imageData 二级制数据(BASE64编码)
 @param key 图片的唯一ID（为了后面点击图片进行后续操作）
 */
- (void)inserImage:(NSData *)imageData key:(NSString *)key;

/**
 *  更新图片的进度条
 @param imageKey 图片的唯一ID
 @param progress 进度值
 */
- (void)inserImageKey:(NSString *)imageKey progress:(CGFloat)progress;


//图片上传成功 替换img标签

/**
 *  图片上传成功，替换成图片地址
 @param imageKey 图片的唯一ID
 @param imgUrl 图片URL
 */
- (void)inserSuccessImageKey:(NSString *)imageKey imgUrl:(NSString *)imgUrl;

/**
 *  删除图片
 @param key 图片的唯一ID
 */
- (void)deleteImageKey:(NSString *)key;


/**
 *  删除图片上传失败的样式

 @param key 图片的唯一ID
 @param isHide 是否显示失败按钮
 */
- (void)removeBtnErrorKey:(NSString *)key isHide:(BOOL)isHide;

/**
 *  设置图片上传失败的样式
 @param key 图片的唯一ID
 */
- (void)uploadErrorKey:(NSString *)key;

/**
 *  设置编辑器内容是否可编辑(解决弹出键盘问题)
 */
- (void)setupContentDisable:(BOOL)disable;


/**
 *  聚焦标题
 */
- (void)showKeyboardTitle;

/**
 *  聚焦内容
 */
- (void)showKeyboardContent;

/**
 *  唤起键盘
 */
- (void)focusTextEditor;

/**
 *  键盘退出
 */
- (void)hiddenKeyboard;


/**
 *  处理HTML的特殊字符转换成文本内容
 */
- (NSString *)removeQuotesFromHTML:(NSString *)html;

@end


@interface NSString (UUID)

/**
 *  获取唯一ID
 */
+ (NSString *)uuid;
- (id)jsonObject;

@end
