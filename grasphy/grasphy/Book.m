//
//  Book.m
//  grasphy
//
//  Created by 山嵜 麿与 on 2014/01/23.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import "Book.h"

@implementation Book
@synthesize book_id = _book_id;
@synthesize title =_title;
@synthesize author = _author;
@synthesize pub_date = _pub_date;
@synthesize cover_img = _cover_img;
@synthesize indexes = _indexes;

- (id) initWithId:(NSString *)abook_id
            title:(NSString *)atitle
           author:(NSString *)anauthor
         pub_date:(NSString *)apub_date
        cover_img:(NSString *)acover_img
          indexes:(NSArray *)aindexes {
    
    if (self = [super init]) {
        _book_id = abook_id;
        _title = atitle;
        _author = anauthor;
        _pub_date = apub_date;
        _cover_img = acover_img;
        _indexes = aindexes;
    }
    return self;
}

@end
