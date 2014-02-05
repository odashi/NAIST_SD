//
//  ViewController.m
//  grasphy
//
//  Created by sd_exercise on 2014/01/15.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import "ViewController.h"
#import "EpubViewController.h"
#import "Book.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    EpubViewController *ev = [[EpubViewController alloc] init];
    //*[ev setBook: books[indexPath.row]];
    Book *abook = [[Book alloc] initWithId: @"44563"
                                     title: @""
                                    author: @""
                                  pub_date: @""
                                 cover_img: @""
                                   indexes: [[NSArray alloc] init]];
    [ev setBook: abook];
    [self presentViewController:ev animated:YES completion:nil];
    
    [self.view addSubview:ev.view];
    
    //NSArray *books = [Book getAllBooks];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
