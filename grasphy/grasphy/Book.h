//
//  Book.h
//  grasphy
//
//  Created by 山嵜 麿与 on 2014/01/23.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject {
    NSString *book_id;
    NSString *title;
    NSString *author;
    NSString *pub_date;
    NSString *cover_img;
    NSArray *indexes;
    int page_num;
}

@end
