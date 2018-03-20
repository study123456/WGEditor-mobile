# WGEditor-mobile
- 采用webview加载一个本地html文件,该html内部编写好js方法用于与oc相互调用,从而达到编辑器功能的效果

- 常用函数
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
