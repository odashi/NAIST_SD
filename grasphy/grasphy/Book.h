//
//  Book.h
//  grasphy
//
//  Created by 山嵜 麿与 on 2014/01/23.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject {
    NSString *_book_id;
    NSString *_title;
    NSString *_author;
    NSString *_pub_date;
    NSString *_cover_img;
    NSArray *_indexes;
    int page_num;
}

@property (nonatomic, retain) NSString *book_id;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *pub_date;
@property (nonatomic, retain) NSString *cover_img;
@property (nonatomic, retain) NSArray *indexes;

- (id) initWithId:(NSString *)abook_id
            title:(NSString *)atitle
           author:(NSString *)anauthor
         pub_date:(NSString *)apub_date
        cover_img:(NSString *)acover_img
          indexes:(NSArray *)aindexes;
@end
