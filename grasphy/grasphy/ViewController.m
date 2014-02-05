//
//  ViewController.m
//  grasphy
//
//  Created by yu.takagi on 2014/02/02.
//  Copyright (c) 2014年 yu.takagi. All rights reserved.
//

#import "ViewController.h"
#import "WvViewController.h"
#import "TableViewController.h"
//#import "EpubViewController.h"
//#import "Book.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myCollectionView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [myCollectionView setDataSource:self];
    [myCollectionView setDelegate:self];
//    UIViewController *wv = [[UIViewController alloc] init];
//   [self presentViewController:wv animated:YES completion:nil];
    

//    NSArray *books = [Book getAllBooks];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar sizeToFit];

    // セグメンテッドコントロール例文
    NSArray *arr = [NSArray arrayWithObjects:@"Shelf", @"List", nil];
    UISegmentedControl *seg =
    [[UISegmentedControl alloc] initWithItems:arr];
    seg.frame = CGRectMake(510, 30, 250, 30);
    seg.selectedSegmentIndex = 0;
    seg.momentary = YES;
    //値が変更された時にhogeメソッドを呼び出す
    [seg addTarget:self action:@selector(list:)
  forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    lv = [[TableViewController alloc] init];
    lv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    lv.view.backgroundColor = [UIColor whiteColor];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -collection view delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //とりあえずセクションは2つ
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){//セクション0には５個
        return 20;
    }else{
        return 0;
    }
}




//Method to create cell at index path
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    if(indexPath.section==0){//セクション0のセル
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = (UILabel *)[cell viewWithTag:1];
        label.text = [NSString stringWithFormat:@"ラベル%d-%d",indexPath.section,indexPath.row];
        
        UIImageView *image = (UIImageView *)[cell viewWithTag:2];
        image.backgroundColor = [UIColor redColor];
//        image.image = books[indexPath.load].cover_img);
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //クリックされたらよばれる
    NSLog(@"Clicked %ld-%ld",(long)indexPath.section,(long)indexPath.row);
    WvViewController *wv = [[WvViewController alloc] init];
    wv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    wv.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:wv animated:YES completion:nil];
    

//    EpubViewController *ev = [[EpubViewController alloc] init];
//    [ev setBook: books[indexPath.row]];
//    [self preentViewController:ev animated:YES completion:nil]
}


-(void)list:(UISegmentedControl*)seg
{
    [self presentViewController:lv animated:YES completion:nil];
}





@end
