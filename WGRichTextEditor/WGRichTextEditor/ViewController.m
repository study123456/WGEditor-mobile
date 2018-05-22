//
//  KWEditArticleViewController.m
//  KaiWen
//
//  Created by 胡文广 on 2017/11/8.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import "ViewController.h"
#import "WGCommon.h"
#import "HXPhotoPicker.h"
#import "HXAlbumListViewController.h"
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define kEditorURL @"richText_editor"
//#define kEditorURL @"z-test"
@interface ViewController ()<UITextViewDelegate,UIWebViewDelegate,KWEditorBarDelegate,KWFontStyleBarDelegate,HXAlbumListViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,assign) BOOL isExitView;

@property (nonatomic,copy) NSString *tempArticleID;

@property (nonatomic,copy) NSString *tempTitle;
@property (nonatomic,copy) NSString *tempContent;

@property (nonatomic,assign) BOOL isLoadFinsh;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) KWEditorBar *toolBarView;
@property (nonatomic,strong) KWFontStyleBar *fontBar;
@property (nonatomic,strong) HXPhotoManager *manager;
@property (nonatomic,strong) HXPhotoView *photoView;
@end

@implementation ViewController
- (KWEditorBar *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [KWEditorBar editorBar];
        _toolBarView.frame = CGRectMake(0,SCREEN_HEIGHT - KWEditorBar_Height, self.view.frame.size.width, KWEditorBar_Height);
        _toolBarView.backgroundColor = COLOR(237, 237, 237, 1);
    }
    return _toolBarView;
}
- (KWFontStyleBar *)fontBar{
    if (!_fontBar) {
        _fontBar = [[KWFontStyleBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolBarView.frame) - KWFontBar_Height - KWEditorBar_Height, self.view.frame.size.width, KWFontBar_Height)];
        _fontBar.delegate = self;
        [_fontBar.heading2Item setSelected:YES];
        
    }
    return _fontBar;
}
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:kEditorURL                                                              ofType:@"html"];
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil];
        [_webView loadHTMLString:htmlCont baseURL:baseURL];
        _webView.scrollView.bounces=NO;
        _webView.hidesInputAccessoryView = YES;
//        _webView.detectsPhoneNumbers = NO;
        
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    /// config
    [self.view addSubview:self.webView];
    [self.view addSubview:self.toolBarView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.toolBarView.delegate = self;
    [self.toolBarView addObserver:self forKeyPath:@"transform" options:
     NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
  
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"HTML" style:UIBarButtonItemStylePlain target:self action:@selector(getHTML)];
    
}
- (void)getHTML{
    
    NSLog(@"%@",[self.webView contentHtmlText]);
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"transform"]){
        
        CGRect fontBarFrame = self.fontBar.frame;
        fontBarFrame.origin.y = CGRectGetMaxY(self.toolBarView.frame)- KWFontBar_Height - KWEditorBar_Height;
        self.fontBar.frame = fontBarFrame;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = CGRectMake(0,64, self.view.frame.size.width,self.view.frame.size.height - KWEditorBar_Height - 64);
}




#pragma mark -webviewdelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"NSEerror = %@",error);

    if([error code] == NSURLErrorCancelled){
        return;
    }
}
//获取IMG标签
-(NSArray*)getImgTags:(NSString *)htmlText
{
    if (htmlText == nil) {
        return nil;
    }
    NSError *error;
    NSString *regulaStr = @"<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:htmlText options:0 range:NSMakeRange(0, [htmlText length])];
    
    return arrayOfAllMatches;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"loadURL = %@",urlString);
    
    [self handleEvent:urlString];
    
    if ([urlString rangeOfString:@"re-state-content://"].location != NSNotFound) {
        NSString *className = [urlString stringByReplacingOccurrencesOfString:@"re-state-content://" withString:@""];
        
        [self.fontBar updateFontBarWithButtonName:className];
        if ([self.webView contentText].length <= 0) {
            [self.webView showContentPlaceholder];
            if ([self getImgTags:[self.webView contentHtmlText]].count > 0) {
                [self.webView clearContentPlaceholder];
            }
        }else{
            [self.webView clearContentPlaceholder];
        }
        
        if ([[className componentsSeparatedByString:@","] containsObject:@"unorderedList"]) {
            [self.webView clearContentPlaceholder];
        }
        
        
    }
    
    [self handleWithString:urlString];
    return YES;
}
#pragma mar - webView监听处理事件
- (void)handleEvent:(NSString *)urlString{
    if ([urlString hasPrefix:@"re-state-content://"]) {
        self.fontBar.hidden = NO;
        self.toolBarView.hidden = NO;
        if ([self.webView contentText].length <= 0) {
//            [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    
    if ([urlString hasPrefix:@"re-state-title://"]) {
        self.fontBar.hidden = YES;
        self.toolBarView.hidden = YES;
    }
    
}


- (void)dealloc{
    @try {
        [self.toolBarView removeObserver:self forKeyPath:@"transform"];
    } @catch (NSException *exception)
    {
        NSLog(@"Exception: %@", exception);
    } @finally {
        // Added to show finally works as well
    }
    self.timer = nil;
}
- (void)isShowPlaceholder{
    
    if ([self.webView contentText].length <= 0)
    {
        [self.webView showContentPlaceholder];
    }else{
        [self.webView clearContentPlaceholder];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}




#pragma mark -editorbarDelegate
- (void)editorBar:(KWEditorBar *)editorBar didClickIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            if (self.toolBarView.transform.ty < 0) {
                [self.webView hiddenKeyboard];
            }else{
                [self.webView showKeyboardContent];
            }
            break;
        case 1:{
//            [self.webView undo];
            [self.webView stringByEvaluatingJavaScriptFromString:@"document.execCommand('undo')"];
            
        }
            break;
        case 2:{
               [self.webView stringByEvaluatingJavaScriptFromString:@"document.execCommand('redo')"];
            
//            [self.webView redo];
        }
            break;
        case 3:
            editorBar.fontButton.selected = !editorBar.fontButton.selected;
            if (editorBar.fontButton.selected) {
                [self.view addSubview:self.fontBar];
            }else{
                [self.fontBar removeFromSuperview];
            }
            break;
        case 4:{
            
            NSString *selectionStr = [self.webView getSelectString];
            if (selectionStr.length > 0) {
                if ([[self.webView getSelection] isEqualToString:@"A"]) {
                    [self.webView clearLink];
                    
                }else{
//                    [self showLinkView:selectionStr];
                }
            }else{
                if (!self.toolBarView.keyboardButton.selected){
                    [self.webView showKeyboardContent];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self showLinkView:nil];
                });
            }
        }break;
        case 5:{
            if (!self.toolBarView.keyboardButton.selected) {
                [self.webView showKeyboardContent];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showPhotos];
                });
            }else{
                [self showPhotos];
            }
            
            
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - fontbardelegate
- (void)fontBar:(KWFontStyleBar *)fontBar didClickBtn:(UIButton *)button{
    
    
    if (self.toolBarView.transform.ty>=0) {
        [self.webView showKeyboardContent];
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
            //            [self.webView heading3];
            
            [self.webView setFontSize:@"2"];
        }
            break;
        case 4:{
            //            [self.webView heading2];
            [self.webView setFontSize:@"3"];
        }
            break;
        case 5:{
            //            [self.webView heading1];
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
            if (button.selected) {
                [self.webView indent];
            }else{
                [self.webView outdent];
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



#pragma mark -keyboard
- (void)keyBoardWillChangeFrame:(NSNotification*)notification{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (frame.origin.y == SCREEN_HEIGHT) {
        [UIView animateWithDuration:duration animations:^{
            self.toolBarView.transform =  CGAffineTransformIdentity;
            self.toolBarView.keyboardButton.selected = NO;
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            self.toolBarView.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
            self.toolBarView.keyboardButton.selected = YES;
            
        }];
    }
}


//-------- 下面为图片选择器(这不是重点)----

#pragma mark -上传图片
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original{
    
    [self.manager clearSelectedList];
 
    if (photoList.count > 0) {
        for (int i = 0; i<photoList.count; i++) {
            
            HXPhotoModel *picM = photoList[i];
            WGUploadPictureModel *uploadM = [[WGUploadPictureModel alloc] init];
            uploadM.image = picM.thumbPhoto;
            uploadM.key = [NSString uuid];
            uploadM.imageData = UIImageJPEGRepresentation(picM.thumbPhoto,0.8f);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //1、插入本地图片
                [self.webView inserImage:uploadM.imageData key:uploadM.key];
                
                //2、模拟网络请求上传图片 更新进度
                [self.webView inserImageKey:uploadM.key progress:0.5];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.webView inserImageKey:uploadM.key progress:1];
                    BOOL error;
                    if (!error) {
                        //3、上传成功替换返回的网络地址图片
                        [self.webView inserSuccessImageKey:uploadM.key imgUrl:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=4278445236,4070967445&fm=173&app=25&f=JPEG?w=218&h=146&s=B1145A915E28110D18B9A940030080B2"];
                    }else{
                        //3、上传失败 显示失败的样式
                        [self.webView uploadErrorKey:uploadM.key];
                    }
                    
                });
                
                
            });
        }
        
    }
    
}

#pragma mark -图片操作
- (BOOL)handleWithString:(NSString *)urlString{
    if ([urlString hasPrefix:@"protocol://iOS?code=uploadResult&data"]) {
        NSRange range = [urlString rangeOfString:@"protocol://iOS?code=uploadResult&data="];
        
        NSMutableDictionary *dict = [[[urlString substringFromIndex:range.length] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] jsonObject];
        
        NSString *meg = [NSString stringWithFormat:@"上传的图片ID为%@",dict[@"imgId"]];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:meg message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"删除图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //根据自身业务需要处理图片操作：如删除、重新上传图片操作等
            //例如删除图片执行函数imgID=key;
            [self.webView deleteImageKey:dict[@"imgId"]];
        }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark -图片选择器
- (void)showPhotos{
    HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
    vc.manager = self.manager;
    vc.delegate = self;
    HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithRootViewController:vc];
    nav.supportRotation = self.manager.configuration.supportRotation;
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.toolBarTitleColor = COLOR(33,189,109,1);
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.imageMaxSize = 5;
        _manager.configuration.selectTogether = NO;
        _manager.configuration.deleteTemporaryPhoto = NO;
        _manager.configuration.rowCount = 4;
        _manager.configuration.reverseDate = YES;
        _manager.configuration.singleJumpEdit = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.supportRotation = NO;
        _manager.configuration.hideOriginalBtn = NO;
    _manager.configuration.navigationTitleColor = [UIColor blackColor];
    _manager.configuration.showDateSectionHeader =NO;
        _manager.configuration.singleSelected = NO;
    }
    return _manager;
}
@end

