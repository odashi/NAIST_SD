//
//  ViewController.h
//  grasphy
//
//  Created by yu.takagi on 2014/02/02.
//  Copyright (c) 2014年 yu.takagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UITableViewController *lv;
}

@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;


@end
