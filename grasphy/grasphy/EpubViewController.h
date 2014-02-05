//
//  EpubViewController.h
//  grasphy
//
//  Created by 山嵜 麿与 on 2014/02/03.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface EpubViewController : UIViewController {
    UIWebView *webView;
    Book *book;
}
- (void)setBook: (Book *)abook;
@end
