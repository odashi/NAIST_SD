//
//  TableViewController.h
//  grasphy
//
//  Created by yu.takagi on 2014/02/10.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <NSXMLParserDelegate>
{
    NSArray *names;
    NSArray *books;
    NSString *nowTagStr;
    NSMutableDictionary *dbook;
}
@end
