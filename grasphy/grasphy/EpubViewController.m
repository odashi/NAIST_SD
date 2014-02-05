//
//  EpubViewController.m
//  grasphy
//
//  Created by 山嵜 麿与 on 2014/02/03.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.


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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBook:(Book *)abook {
    book = abook;
    [self makeUIWebView];
}

- (void)makeUIWebView {
    
    // set uiwebview
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height + 20);
    webView = [[UIWebView alloc] initWithFrame:rect];
    webView.scalesPageToFit = YES;
    
    // load epub
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"epubview"];
    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
    [self.view addSubview:webView];
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var ID=%@", book.book_id]];
}

@end
