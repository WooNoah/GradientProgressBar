//
//  SecViewController.m
//  testLayer
//
//  Created by Noah on 2018/5/23.
//  Copyright © 2018年 Noah. All rights reserved.
//

#import "SecViewController.h"
#import "OpenAccountProgressView.h"

@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Do any additional setup after loading the view.
    OpenAccountProgressView *progressView = [[OpenAccountProgressView alloc]initWithFrame:CGRectMake(50, 100, 200, 16)];
    progressView.progress = 40.f;
    progressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
