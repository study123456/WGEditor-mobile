//
//  KWEditArticleViewController.m
//  KaiWen
//
//  Created by 胡文广 on 2017/11/8.
//  Copyright © 2017年 胡文广. All rights reserved.
//

#import "ViewController.h"
#import "WGBaseRichEditorViewController.h"
#import "WGAudioRichEditorViewController.h"
#import "WGVideoRichEditorViewController.h"
#import "WGAVRichEditorViewController.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *dicts;
@property (nonatomic,strong) NSArray *titles;
@end

@implementation ViewController
- (NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@{@"WGBaseRichEditorViewController":@"编辑器基础功能"},@{@"WGAudioRichEditorViewController":@"可传音频"},@{@"WGVideoRichEditorViewController":@"可传视频"},@{@"WGAVRichEditorViewController"   :@"可传音视频"}];
    }
    return _titles;
}
- (void)loadView{
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = [UIView new];
    self.view = _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid= @"cellID";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
    }
    NSDictionary *dict = self.titles[indexPath.row];
    cell.textLabel.text = dict.allValues[0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.titles[indexPath.row];
    NSString *vcClass = dict.allKeys[0];
    UIViewController *vc = [[NSClassFromString(vcClass) alloc] init];
    vc.title = dict.allValues[0];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
@end
    
