//
//  ResultViewController.m
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/2.
//  Copyright © 2019 wenguang. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property (nonatomic,strong) UILabel *contentL;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WG_WHITE;
    
    self.contentL = [UILabel new];
    self.contentL.font = [UIFont systemFontOfSize:16];
    self.contentL.numberOfLines = 0;
    self.contentL.text = self.text;
    [self.view addSubview:self.contentL];
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
