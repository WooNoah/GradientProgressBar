//
//  ThirdViewController.m
//  testLayer
//
//  Created by Noah on 2018/5/24.
//  Copyright © 2018年 Noah. All rights reserved.
//

#import "ThirdViewController.h"
#import "OpenAccountProgressView.h"
#import "EvenOddView.h"

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet OpenAccountProgressView *progressBar;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.progressBar.progress = 22.f;
    
    
    EvenOddView *view = [[EvenOddView alloc]initWithFrame:CGRectMake(50, 200, 200, 200)];
//    EvenOddView *view = [[EvenOddView alloc]init];
//    view.backgroundColor = [UIColor greenColor];
    view.layer.borderWidth = 1.f;
    view.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:view];
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
