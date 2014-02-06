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
    NSString *_cover_img;
    NSString *_src;
    int _difficulty;
    int _numwords;
    int _numpages;
    NSString *_publication_timestamp;
    NSString *_create_timestamp;
}

@property (nonatomic, retain) NSString *book_id;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *cover_img;
@property (nonatomic, retain) NSString *src;
@property int difficulty;
@property int numwords;
@property int numpages;
@property (nonatomic, retain) NSString *publication_timestamp;
@property (nonatomic, retain) NSString *create_timestamp;

- (id) initWithId:(NSString *)abook_id
            title:(NSString *)atitle
           author:(NSString *)anauthor
        cover_img:(NSString *)acover_img
              src:(NSString *)asrc
       difficulty:(int)adifficulty
         numwords:(int) anumwords
         numpages:(int) anumpages
publication_timestamp:(NSString *)apublication_timestamp
 create_timestamp: (NSString *)acreate_timestamp;

+ (NSArray *) getAllBooks;
@end
