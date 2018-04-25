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


三、More 更多

如果你发现了bug，请提一个issue。 欢迎给我提pull requests。
请尽可能详细地描述系统版本、手机型号、库的版本、崩溃日志和复现步骤，请先更新到最新版再测试一下，如果新版还存在再提~如果已有开启的类似issue，请直接在该issue下评论说出你的问题

四、Other 其它

常见问题

Q:自动换行问题
A:排期中，优先级高

Q:图片上传完善(模拟网络图片上传)
A:排期中，优先级高
