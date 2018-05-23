//
//  ViewController.m
//  testLayer
//
//  Created by Noah on 2018/5/23.
//  Copyright © 2018年 Noah. All rights reserved.
//

#import "ViewController.h"
#import "OpenAccountProgressView.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    OpenAccountProgressView *progressView = [[OpenAccountProgressView alloc]initWithFrame:CGRectMake(10, 100, 300, 16)];
    OpenAccountProgressView *progressView = [[OpenAccountProgressView alloc]init];
    progressView.progress = 50.f;
    progressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:progressView];

    一个渐变进度条，使用CAGradientLayer和CAShapeLayer实现
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 16));
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(10);
    }];
}

- (IBAction)btnClick:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
