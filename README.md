# WGEditor-mobile
采用系统浏览器做的一款富文本编辑器工具。
原理就是使用UIWebView加载一个本地的一个html文件，从而达到编辑器功能的效果！

![image](https://github.com/study123456/WGEditor-mobile/blob/master/rextEditor.GIF)   

一、Installation 安装

#import "WGCommon.h"

二、Example 例子

- 常用函数
- (NSString *)titleText;
- (void)setupTitle:(NSString *)title;
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
//插入图片
- (void)inserImage:(UIImage *)image alt:(NSString *)alt;
.....

三、上传图片

	实现思路：图片上传七牛服务器举例
	
	![image](https://github.com/study123456/WGEditor-mobile/blob/master/design_up.png)   


//开始插入图片
- (void)inserImage:(NSData *)imageData key:(NSString *)key;
//图片上传中
- (void)inserImageKey:(NSString *)imageKey progress:(CGFloat)progress;
//图片上传成功
- (void)inserSuccessImageKey:(NSString *)imageKey imgUrl:(NSString *)imgUrl;
//删除图片
- (void)deleteImageKey:(NSString *)key;
// 上传失败
- (void)uploadErrorKey:(NSString *)key;

  实现效果

![image](https://github.com/study123456/WGEditor-mobile/blob/master/uploadImage.gif)   

四、More 更多

如果你发现了bug，请提一个issue。 欢迎给我提pull requests。
请尽可能详细地描述系统版本、手机型号、库的版本、崩溃日志和复现步骤，请先更新到最新版再测试一下，如果新版还存在再提~如果已有开启的类似issue，请直接在该issue下评论说出你的问题

五、Other 其它

本次更新

1>图片上传功能

常见问题

Q:自动换行问题
A:排期中，优先级高


