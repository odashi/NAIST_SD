//
//  ViewController.h
//  grasphy
//
//  Created by sd_exercise on 2014/01/15.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, NSXMLParserDelegate>
{
    UITableViewController *tv;
    NSArray *books;
    NSString *nowTagStr;
    NSMutableDictionary *dbook;
    NSArray *booklist;
}
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end
