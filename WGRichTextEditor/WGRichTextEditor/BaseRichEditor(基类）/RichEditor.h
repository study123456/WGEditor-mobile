//
//  RichEditor.h
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/1.
//  Copyright © 2019 wenguang. All rights reserved.
//git地址:https://github.com/study123456/WGEditor-mobile

#ifndef RichEditor_h
#define RichEditor_h

#import <WebKit/WebKit.h>
#import "WKWebView+WGWKWebViewExtension.h"
#import "WGEditorToolBar.h"
#import "WGFontStyleBar.h"
#import "UIView+Utility.h"
#import "WGUploadFileModel.h"
#import "WGUploadFileTool.h"

#define WGtabBarLineColor WGCOLORA(216,216,216)

#define WGCOLORA(r,g,b) (WG_COLOR(r,g,b,1))
#define WG_CLEAR [UIColor clearColor]
#define WG_WHITE [UIColor whiteColor]
#define WG_BLACK [UIColor blackColor]
#define WG_BLUE  [UIColor blueColor]
#define WG_RED [UIColor redColor]
#define WG_GREEN [UIColor greenColor]
#define WG_YELLOW [UIColor yellowColor]

//通过三色值获取颜色对象
#define WG_COLOR(r,g,b,a) ([UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a])

#define WG_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define WG_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define WG_SafeAreaBottomHeight ((WG_SCREEN_HEIGHT == 812.0 || WG_SCREEN_HEIGHT == 896.0 )? 34 : 0)

#define WG_SafeAreaTopHeight ((WG_SCREEN_HEIGHT == 812.0 || WG_SCREEN_HEIGHT == 896.0 )? 88 : 64)
#define WEAKSELF __weak typeof(self)  weakSelf = self;
#endif /* RichEditor_h */
