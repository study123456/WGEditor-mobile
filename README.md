# WGEditor-mobile
采用系统浏览器做的一款富文本编辑器工具。
原理就是使用WKWebView加载一个本地的一个html文件，从而达到编辑器功能的效果！
由于浏览器的一些特性等，富文本编辑器手机端很难做的完美，慢慢完善，欢迎提出好的建议。

![image](https://github.com/study123456/WGEditor-mobile/blob/master/rextEditor.GIF)   

一、Installation 安装

#import "RichEditor.h"

二、Example 例子

- 常用函数
- (void)titleTextHandleCallback:(void (^)(id _Nullable obj, NSError *
_Nullable error))callback;
- (void)setupTitle:(NSString *)title;
- (void)contentTextHandleCallback:(void (^)(id _Nullable obj, NSError *
_Nullable error))callback;
- (void)contentHtmlTextHandleCallback:(void (^)(id _Nullable obj,
NSError * _Nullable error))callback;
- (void)setupContent:(NSString *)content;
- (void)updatePlaceHolderStatu;
- (void)placeHolderWithHidden:(BOOL)isHidden;

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
.....

三、上传图片

	实现思路：图片上传七牛服务器举例
https://github.com/study123456/WGEditor-mobile/blob/master/design_up.png


//插入本地图片
- (void)insetImage:(NSData *)imageData key:(NSString *)key;
//上传中
- (void)insetImageKey:(NSString *)imageKey progress:(CGFloat)progress;
//图片上传成功
- (void)insetSuccessImageKey:(NSString *)imageKey imgUrl:(NSString *)imgUrl;
//删除图片
- (void)deleteImageKey:(NSString *)key;
// 上传失败
- (void)uploadErrorKey:(NSString *)key;
- (void)removeBtnErrorKey:(NSString *)key isHide:(BOOL)isHide;

  实现效果

![image](https://github.com/study123456/WGEditor-mobile/blob/master/uploadImage.gif)   

四、More 更多

如果你发现了bug，请先在Issues中搜索答案。
没有请提一个issues。 欢迎给我提pull requests。
请尽可能详细地描述系统版本、手机型号、库的版本、崩溃日志和复现步骤，请先更新到最新版再测试一下，如果新版还存在再提~如果已有开启的类似issue，请直接在该issue下评论说出你的问题

五、Other 其它

近期更新
1、由于iOSUIWebView被弃用，修改UIWebview替换成WKWebView，性能更优
2、工具条可扩展
3、易集成 封装基类

常见问题

Q:自动换行问题
A:音视频排期中


