//
//  WvViewController.m
//  grasphy
//
//  Created by yu.takagi on 2014/02/05.
//  Copyright (c) 2014年 yu.takagi. All rights reserved.
//

#import "WvViewController.h"

@interface WvViewController ()

@end

@implementation WvViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 50, 30);
    [btn setTitle:@"押してね" forState:UIControlStateNormal];
    [btn setTitle:@"ぽち" forState:UIControlStateHighlighted];
    [btn setTitle:@"押せません" forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(hoge:)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hoge:(UIButton*)button{
    // ここに何かの処理を記述する
    [self dismissViewControllerAnimated:YES completion:nil];
    // （引数の button には呼び出し元のUIButtonオブジェクトが引き渡されてきます）
}




@end
