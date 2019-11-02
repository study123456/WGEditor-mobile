//
//  WGBaseRichEditorViewController.m
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/1.
//  Copyright © 2019 wenguang. All rights reserved.
//

#import "WGBaseRichEditorViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CustomIOSAlertView.h"
#import "WGInputAlertView.h"
#import <TZImagePickerController/TZImagePickerController.h>


#import "ResultViewController.h"
@interface WGBaseRichEditorViewController ()
<
WKNavigationDelegate,
WGEditorToolBarDelegate,
WGFontStyleBarDelegate,
CustomIOSAlertViewDelegate
>

@property (nonatomic,strong) CustomIOSAlertView *alertView;
@property (nonatomic,strong) WGInputAlertView *inputAlertView;
@property (nonatomic,strong) WGFontStyleBar *fontBar;
@property (nonatomic,strong) TZImagePickerController *imagePickerVc;
@property (nonatomic,strong) NSMutableArray <WGUploadFileModel*>*uploadArr;
@end

@implementation WGBaseRichEditorViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WG_WHITE;
    //防止导航出现色差
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.backgroundColor = WG_WHITE;
    //防止偏移
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //添加webview
    [self configBaseWebView];
    
    //添加工具条
    [self configToolBar];
    
    //键盘高度处理
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)configBaseWebView{
    //添加WebView加载HTML
    self.webView.frame = CGRectMake(0, 0, WG_SCREEN_WIDTH, WG_SCREEN_HEIGHT - 44);
    [self.view addSubview:self.webView];
    
    if (self.webHTML == nil) {
        self.webHTML = @"RichEditor.html";
    }
    NSString * htmlCont = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.webHTML ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
    UIBarButtonItem *itemL = [[UIBarButtonItem alloc] initWithTitle:@"Title" style:UIBarButtonItemStylePlain target:self action:@selector(getTitle)];
    UIBarButtonItem *itemM  = [[UIBarButtonItem alloc] initWithTitle:@"TEXT" style:UIBarButtonItemStylePlain target:self action:@selector(getText)];
    UIBarButtonItem *itemR = [[UIBarButtonItem alloc] initWithTitle:@"HTML" style:UIBarButtonItemStylePlain target:self action:@selector(getHTML)];
    self.navigationItem.rightBarButtonItems = @[itemR,itemL,itemM];
}
- (void)getTitle{
    if ([self isUploadResult]) {
        [SVProgressHUD showErrorWithStatus:@"图片未上传成功"];
        return;
    }
    
    [self.webView titleTextHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        NSLog(@"%@",obj);
        
        ResultViewController *resultVc = [ResultViewController new];
        resultVc.text = obj;
        [self.navigationController pushViewController:resultVc animated:YES];
    }];
}
- (void)getText{
    if ([self isUploadResult]) {
        [SVProgressHUD showErrorWithStatus:@"图片未上传成功"];
        return;
    }
    [self.webView contentTextHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        NSLog(@"%@",obj);
        ResultViewController *resultVc = [ResultViewController new];
        resultVc.text = obj;
        [self.navigationController pushViewController:resultVc animated:YES];
    }];
}
- (void)getHTML{
    if ([self isUploadResult]) {
        [SVProgressHUD showErrorWithStatus:@"图片未上传成功"];
        return;
    }
    [self.webView contentHtmlTextHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        NSLog(@"%@",obj);
        ResultViewController *resultVc = [ResultViewController new];
        resultVc.text = obj;
        [self.navigationController pushViewController:resultVc animated:YES];
    }];
}
- (void)configToolBar{
    
    if (self.toolBar == nil) {
        CGFloat toolBarH = IS_IPhoneX_All?50:KWEditorBar_Height;
        self.toolBar = [[WGEditorToolBar alloc] initToolBarStyle:WGEditorToolBarStyleNoneBasic withFrame:CGRectMake(0,WG_SCREEN_HEIGHT - toolBarH - WG_SafeAreaTopHeight, self.view.width, toolBarH)];
    }
    
    //添加工具条
    self.toolBar.delegate = self;
    [self.view addSubview:self.toolBar];
    //工具条处理
    [self.toolBar addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"transform"]){
//        if (self.alertView && self.toolBar.transform.ty < 0) {
//            [self.alertView changeFrame:self.toolBar.frame.origin.y];
//        }
        CGRect fontBarFrame = self.fontBar.frame;
        fontBarFrame.origin.y = CGRectGetMaxY(self.toolBar.frame)- KWFontBar_Height - KWEditorBar_Height;
        self.fontBar.frame = fontBarFrame;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
///MARK: lazy
- (WKWebView *)webView{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces=NO;
        _webView.hidesInputAccessoryView = YES;
    }
    return _webView;
}
- (WGFontStyleBar *)fontBar{
    if (!_fontBar) {
        _fontBar = [[WGFontStyleBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolBar.frame) - KWFontBar_Height - KWEditorBar_Height, self.view.frame.size.width, KWFontBar_Height)];
        _fontBar.delegate = self;
        [_fontBar.heading2Item setSelected:YES];
    }
    return _fontBar;
}

- (TZImagePickerController *)imagePickerVc{
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
        _imagePickerVc.showSelectBtn = NO;
    }
    return _imagePickerVc;
}
- (NSMutableArray<WGUploadFileModel *> *)uploadArr{
    if (_uploadArr == nil) {
        _uploadArr = [NSMutableArray array];
    }
    return _uploadArr;
}
///MARK:WKWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    NSString *urlString = navigationAction.request.URL.absoluteString;
    
    NSLog(@"decidePolicyForNavigationAction = %@",urlString);
    [self.webView updatePlaceHolderStatu];
    [self fontBarUpdateWithString:urlString];
    [self handleEvent:urlString];
    [self handleWithString:urlString];
    WEAKSELF
    [webView getCaretYPositionPositionHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        CGFloat currentPos = [obj floatValue];
        if (currentPos  > WG_SCREEN_HEIGHT - weakSelf.keboardHeight - 49) {
            [weakSelf.webView autoScrollTop:currentPos+weakSelf.toolBar.height];
        }
    }];
    decisionHandler(WKNavigationActionPolicyAllow); // 必须实现 加载
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}
///MARK:图片操作
- (BOOL)handleWithString:(NSString *)urlString{
    if ([urlString hasPrefix:@"protocol://iOS?code=uploadResult&data="]){
        //获取当前
          NSRange range = [urlString rangeOfString:@"protocol://iOS?code=uploadResult&data="];
      
        NSString *dictString = [urlString substringFromIndex:range.length];
        
        NSLog(@"截取后：%@",dictString);
        NSDictionary *dict = [WGUploadFileModel jsonObject:[dictString stringByRemovingPercentEncoding]];
        if(dict[@"imgId"]) {
            NSLog(@"click = %@",dict[@"imgId"]);
            WGUploadFileModel *imgM = [self fileModelWithKey:dict[@"imgId"]];
            if(imgM.state == WGUploadFileStateError){
                [self actionSheetWitType:1 handleFileM:imgM];
            }else if(imgM.state == WGUploadFileStateSuccess){
                [self actionSheetWitType:2 handleFileM:imgM];
            }
        }
        return NO;
    }
    return YES;
}
- (void)actionSheetWitType:(NSInteger)type handleFileM:(WGUploadFileModel *)fileM{
    
    NSString *btnTitle = type == 1?@"重新上传":@"删除";
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"操作提示" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (type == 1) {
            //移除失败样式
            [self.webView removeBtnErrorKey:fileM.key isHide:TRUE];
            //重传
            WEAKSELF
            [[WGUploadFileTool alloc] upLoadFileModel:fileM Callback:^(NSString * _Nonnull key, float percent, id  _Nullable obj, NSError * _Nullable error) {
              
                WGUploadFileModel *fileM = [weakSelf fileModelWithKey:key];
                if (percent < 1) {
                    //正在上传
                    [weakSelf.webView insetImageKey:fileM.key progress:percent];
                }else{
                    
                    if (obj) {
                        //上传成功
                        fileM.state = WGUploadFileStateSuccess;
                        NSString *testUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=210671490,1554278141&fm=173&app=25&f=JPEG?w=638&h=445&s=9C366790E4892B4F26293C810300A088";
                        [weakSelf successWithKey:fileM.key url:testUrl];
                    }else{
                        //上传失败
                        fileM.state = WGUploadFileStateError;
                        [weakSelf.webView uploadErrorKey:fileM.key];
                    }
                    
                }
            }];
        }else{
            //删除
            [self.webView deleteImageKey:fileM.key];
            
            [self.uploadArr enumerateObjectsUsingBlock:^(WGUploadFileModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([fileM.key isEqualToString:obj.key]) {
                    [self.uploadArr removeObject:fileM];
                    *stop = YES;
                }
            }];
        }
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:okAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:^{
        [self.webView setupContentDisable:TRUE];
    }];
}
- (void)handleEvent:(NSString *)urlString{
    BOOL isEditorTitle = [urlString hasPrefix:@"re-state-title://"] || [urlString hasPrefix:@"re-title-callback"];
    self.fontBar.hidden = isEditorTitle;
    self.toolBar.hidden = isEditorTitle;
}

- (void)fontBarUpdateWithString:(NSString *)urlString{
    if ([urlString rangeOfString:@"re-state-content://"].location != NSNotFound) {
        NSString *className = [urlString stringByReplacingOccurrencesOfString:@"re-state-content://" withString:@""];
        
        [self.fontBar updateFontBarWithButtonName:className];
        
        if ([[className componentsSeparatedByString:@","] containsObject:@"unorderedList"]) {
//            [self.webView placeHolderWithHidden:YES];
        }
    }
}
//MARK:EditorBarDelegate
-(void)editorToolBar:(WGEditorToolBar *)toolBar clickBtn:(WGEditorToolBarAction)toolBarAction{
    switch (toolBarAction) {
        case WGEditorToolBarActionDefault:
        {
            if (self.toolBar.keyBoardSelected) {
                [self.webView hiddenKeyboard];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.webView contentBecomeFirstResponder];
                });
            }
        }
            break;
        case WGEditorToolBarActionPhoto: {
            if (self.toolBar.keyBoardSelected) {
                [self showPhotoPicker];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.webView contentBecomeFirstResponder];
                });
                [self showPhotoPicker];
            }
        }
            break;
        case WGEditorToolBarActionVideo:
            [self videoAction];
            break;
        case WGEditorToolBarActionAudio:
            [self audioAction];
            break;
        case WGEditorToolBarActionFont:
        {
            self.toolBar.fontSelected = !self.toolBar.fontSelected;
            if (self.toolBar.fontSelected) {
                [self.view addSubview:self.fontBar];
            }else{
                [self.fontBar removeFromSuperview];
            }
        }
            break;
        case WGEditorToolBarActionUndo:
            [self.webView undo];
            break;
        case WGEditorToolBarActionRedo:
            [self.webView redo];
            break;
        case WGEditorToolBarActionLink:
            [self linkAction];
            break;
        case WGEditorToolBarActionSetting:
            [self settingAction];
            break;
        default:
            break;
    }
}
- (void)videoAction{
    NSLog(@"base videoAction");
}
- (void)audioAction{
    NSLog(@"base audioAction");
}
- (void)settingAction{
    NSLog(@"base settingAction");
}

///MARK:FontBarDelegate
- (void)fontBar:(WGFontStyleBar *)fontBar didClickBtn:(UIButton *)button{
    if (self.toolBar.transform.ty>=0) {
        [self.webView contentBecomeFirstResponder];
    }
    switch (button.tag) {
        case 0:{
            [self.webView bold];
        }
            break;
        case 1:{
            [self.webView underline];
        }
            break;
        case 2:{
            [self.webView italic];
        }
            break;
        case 3:{
            [self.webView setFontSize:@"2"];
        }
            break;
        case 4:{
            [self.webView setFontSize:@"3"];
        }
            break;
        case 5:{
            [self.webView setFontSize:@"4"];
        }
            break;
        case 6:{
            [self.webView justifyLeft];
        }
            break;
        case 7:{
            [self.webView justifyCenter];
        }
            break;
        case 8:{
            [self.webView justifyRight];
        }
            break;
        case 9:{
            [self.webView unorderlist];
        }
            break;
        case 10:{
            button.selected = !button.selected;
            if (fontBar.unorderlistItem.selected) {
                if (button.selected) {
                    [self.webView outdent];
                }else{
                    [self.webView indent];
                }
            }else{
                if (!button.selected) {
                    [self.webView outdent];
                }else{
                    [self.webView indent];
                }

            }
        }
            break;

        case 11:{

        }
            break;
        default:
            break;
    }
}
- (void)fontBarResetNormalFontSize{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView normalFontSize];
    });
}
///MARK:上传图片
- (void)showPhotoPicker{
    self.imagePickerVc.allowPickingVideo = NO;
    WEAKSELF
    [self.imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
       
        for (UIImage *selImg in photos) {
            WGUploadFileModel *fileM = [WGUploadFileModel new];
            fileM.fileData = UIImageJPEGRepresentation(selImg,0.8f);
            fileM.key = fileM.uuid;
            [weakSelf.uploadArr addObject:fileM];
            
            [weakSelf.webView insetImage:fileM.fileData key:fileM.key];
        }
        
        [[WGUploadFileTool alloc] upLoadFileModels:[weakSelf.uploadArr copy] Callback:^(NSString * _Nonnull key, float percent, id  _Nullable obj, NSError * _Nullable error) {
            
            WGUploadFileModel *fileM = [weakSelf fileModelWithKey:key];
            if (percent < 1) {
                //正在上传
                [weakSelf.webView insetImageKey:fileM.key progress:percent];
            }else{
                
//                if (obj) {
//                    //上传成功
//                    fileM.state = WGUploadFileStateSuccess;
//                    NSString *testUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=210671490,1554278141&fm=173&app=25&f=JPEG?w=638&h=445&s=9C366790E4892B4F26293C810300A088";
//                    [weakSelf successWithKey:fileM.key url:testUrl];
//                }else{
                    //上传失败
                    fileM.state = WGUploadFileStateError;
                    [weakSelf.webView uploadErrorKey:fileM.key];
//                }
                
            }
            
        }];
        
    }];
    [self presentViewController:self.imagePickerVc animated:YES completion:nil];
}
///MARK:判断是否有上传失败的图片
- (BOOL)isUploadResult{
    if (self.uploadArr<=0) {return NO;}
    BOOL result = NO;
    for (WGUploadFileModel *fileM in self.uploadArr) {
        if (fileM.state != WGUploadFileStateSuccess) {
            result = YES;
            break;
        }
    }
    return result;
}
///MARK:返回对应的模型
- (WGUploadFileModel *)fileModelWithKey:(NSString *)key{
    if(self.uploadArr.count<=0) return nil;
    WGUploadFileModel *upfileM;
    for (WGUploadFileModel *fileM in self.uploadArr) {
        if([fileM.key isEqualToString:key]){
            upfileM = fileM;
            break;
        }
    }
    return upfileM;
}
///MARK:删除图片的对应模型
- (void)removePicture:(WGUploadFileModel *)upFile{
    [self.uploadArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WGUploadFileModel *fileM = obj;
        if ([fileM.key isEqualToString:upFile.key]) {
            [self.uploadArr removeObject:fileM];
        }
    }];
}
///MARK:上传中更新进度条
- (void)updatePicWithKey:(NSString *)key progress:(CGFloat)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView insetImageKey:key progress:progress];
    });
}
///MARK:上传成功更新
- (void)successWithKey:(NSString *)key url:(NSString *)url{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView insetSuccessImageKey:key imgUrl:url];
    });
}

//MARK:插入链接
- (void)linkAction{
    [_alertView close];
    [self.webView getSelectStringHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        if (error == nil) {
            NSString *selectionStr = obj;
            if (selectionStr.length > 0) {
                
                [self.webView getSelectionHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
                   
                    if (error == nil) {
                        NSString *tagStr = obj;
                        if ([tagStr isEqualToString:@"A"]) {
                            [self.webView clearLink];
                        }else{
                            [self showLinkView:selectionStr];
                        }
                    }
                }];
            }else{
                if (!self.toolBar.keyBoardSelected){
                    [self.webView contentBecomeFirstResponder];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showLinkView:nil];
                });
            }
        }
    }];
}

- (CustomIOSAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[CustomIOSAlertView alloc] init];
    }
    return _alertView;
}
- (WGInputAlertView *)inputAlertView{
    if (!_inputAlertView) {
        _inputAlertView = [WGInputAlertView inputAlertView];
    }
    return _inputAlertView;
}
- (void)showLinkView:(NSString *)content{
    
    self.inputAlertView.frame = CGRectMake(0,10,[UIScreen mainScreen].bounds.size.width - 32, WGInputAlertView_H);
    self.inputAlertView.backgroundColor = [UIColor whiteColor];
    [self.alertView setContainerView:self.inputAlertView];
    // Modify the parameters
    [self.alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确认", nil]];
    [self.alertView setDelegate:self];
    
    [self.alertView setUseMotionEffects:true];
    
    [self.alertView show];
    
    if (self.toolBar.transform.ty < 0) {
        [self.alertView changeFrame:self.toolBar.frame.origin.y];
    }
    
    if (content.length > 0) {
        _inputAlertView.topTextField.text = content;
        _inputAlertView.topTextField.textColor = [UIColor grayColor];
        _inputAlertView.topTextField.enabled = FALSE;
        [_inputAlertView.midTextField becomeFirstResponder];
    }else{
        [_inputAlertView.topTextField becomeFirstResponder];
    }
    
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (_inputAlertView.topTextField.text.length <= 0) {
            [SVProgressHUD showErrorWithStatus:@"文本内容不能为空"];
            return;
        }
        if (_inputAlertView.midTextField.text.length <= 0) {
            [SVProgressHUD showErrorWithStatus:@"链接地址不能为空"];
            return;
        }
        
        [self.webView insertLinkUrl:_inputAlertView.midTextField.text title:_inputAlertView.topTextField.text content:_inputAlertView.bottomTextField.text.length?_inputAlertView.bottomTextField.text:@""];
    }
    
    [self.webView removeAllRange];
    
    [self dismissAlertView];
}
- (void)dismissAlertView{
    [self.alertView close];
    [self.alertView removeFromSuperview];
    [_inputAlertView removeFromSuperview];
    self.alertView = nil;
    _inputAlertView = nil;
}
- (void)dealloc{
    NSLog(@"%@ dealloc",self);
    [self clearOutPut];
}
- (void)clearOutPut{
    if (_webView) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    }
    @try {
        [self.toolBar removeObserver:self forKeyPath:@"transform"];
    } @catch (NSException *exception){
        NSLog(@"Exception: %@", exception);
    } @finally {
        // Added to show finally works as well
    }
//    [_timer invalidate];
//    _timer = nil;
//    _ctx = nil;
}
///MARK:KEYBOARD
- (void)keyBoardWillChangeFrame:(NSNotification*)notification{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keboardHeight = frame.size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat toolBarHeight = self.toolBar.frame.size.height;
    if (frame.origin.y == WG_SCREEN_HEIGHT) {
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform =  CGAffineTransformIdentity;
            self.toolBar.keyBoardSelected = NO;
            [self.webView setHeight: WG_SCREEN_HEIGHT - toolBarHeight];
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
            self.toolBar.keyBoardSelected = YES;
            [self.webView setHeight:WG_SCREEN_HEIGHT - frame.size.height-toolBarHeight];
        }];
    }
}
@end
