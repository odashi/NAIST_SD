//
//  EpubViewController.m
//  grasphy
//
//  Created by 山嵜 麿与 on 2014/01/22.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import "EpubViewController.h"

@interface EpubViewController ()

@end

@implementation EpubViewController

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
    // Do any additional setup after loading the view from its nib.
    
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height + 20);
    UIWebView *wv = [[UIWebView alloc] initWithFrame:rect];
    wv.scalesPageToFit = NO;
    [self.view addSubview:wv];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"epubview"];
    NSLog(@"%@", path);
    [wv loadRequest: [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
