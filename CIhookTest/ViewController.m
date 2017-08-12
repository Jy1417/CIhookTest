//
//  ViewController.m
//  CIhookTest
//
//  Created by spomer on 2017/8/12.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSString  *title;


@end

@implementation ViewController


- (instancetype)initWithTitle:(NSString *)title
{
    if (self) {
        self = [super init];
        self.title = title;
    }
    return self;
}


- (instancetype)init
{
    if (self) {
        self.title = @"测试";
    }
    return self;
}



static  int  static_index = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor purpleColor];
    
    UILabel  *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    lb.text = self.title;
    lb.backgroundColor = [UIColor  blueColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor  orangeColor];
    [self.view addSubview:lb];
    
    
    UIButton  *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(40, 300, self.view.frame.size.width - 80, 100);
    NSString  *title = [NSString stringWithFormat:@"进入下一页：%d",static_index];
    [bt setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(toNextView) forControlEvents:UIControlEventTouchDown];
    
    
}





- (void)toNextView
{
    NSString  *title = [NSString stringWithFormat:@"我是：%d",static_index++];
    ViewController  *lv = [[ViewController alloc] initWithTitle:title];
    
    UINavigationController  *nvl = [[UINavigationController alloc] initWithRootViewController:lv];
    [self presentViewController:nvl animated:YES completion:^{
        
        
        
    }];
    
   

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
