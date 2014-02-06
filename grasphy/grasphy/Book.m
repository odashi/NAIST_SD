//
//  Book.m
//  grasphy
//
//  Created by 山嵜 麿与 on 2014/01/23.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import "Book.h"
#import "FMDatabase.h"

@implementation Book
@synthesize book_id = _book_id;
@synthesize title =_title;
@synthesize author = _author;
@synthesize cover_img = _cover_img;
@synthesize src = _src;
@synthesize difficulty = _difficulty;
@synthesize numwords = _numwords;
@synthesize numpages = _numpages;
@synthesize publication_timestamp = _publication_timestamp;
@synthesize create_timestamp = _create_timestamp;


- (id) initWithId:(NSString *)abook_id
            title:(NSString *)atitle
           author:(NSString *)anauthor
        cover_img:(NSString *)acover_img
              src:(NSString *)asrc
       difficulty:(int)adifficulty
         numwords:(int) anumwords
         numpages:(int) anumpages
publication_timestamp:(NSString *)apublication_timestamp
 create_timestamp: (NSString *)acreate_timestamp {
    
    if (self = [super init]) {
        _book_id = abook_id;
        _title = atitle;
        _author = anauthor;
        _cover_img = acover_img;
        _src = asrc;
        _difficulty = adifficulty;
        _numwords = anumwords;
        _numpages = anumpages;
        _publication_timestamp = apublication_timestamp;
        _create_timestamp = acreate_timestamp;
    }
    return self;
}

+ (NSArray *) getAllBooks {
        
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir   = [paths objectAtIndex:0];
    FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
    
    NSString *sql=@"select * from books;";
    [db open];
    FMResultSet *results = [db executeQuery:sql];
    
    
    NSMutableArray *books = [[NSMutableArray alloc] init];
    while([results next]){
        
        Book *abook = [[Book alloc] initWithId: [results stringForColumn:@"id"]
                                         title: [results stringForColumn:@"title"]
                                        author: [results stringForColumn:@"author"]
                                     cover_img: [results stringForColumn:@"cover_img"]
                                           src: [results stringForColumn:@"src"]
                                    difficulty: [[results stringForColumn:@"difficulty"] integerValue]
                                      numwords: [[results stringForColumn:@"numwords"] integerValue]
                                      numpages: [[results stringForColumn:@"numpages"] integerValue]
                         publication_timestamp: [results stringForColumn:@"publication_timestamp"]
                              create_timestamp: [results stringForColumn:@"create_timestamp"]];
        [books addObject:abook];

    }

    [db close];

    
    return (NSArray *)books;
}

@end
