//
//  ViewController.m
//  grasphy
//
//  Created by sd_exercise on 2014/01/15.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "EpubViewController.h"
#import "Book.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initDB];
    NSArray *books = [Book getAllBooks];
    
    NSLog(@"%d", [books count]);
    
    // set and show epub view controler
    EpubViewController *ev = [[EpubViewController alloc] init];
    
    [ev setBook: [books objectAtIndex:0]];
    [self presentViewController:ev animated:YES completion:nil];
    [self.view addSubview:ev.view];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDB {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir   = [paths objectAtIndex:0];
  
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"file.db"]])
    {
        NSLog(@"BEGIN : init DB");
        
        // create database
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
        NSString *sql = @"create table books (id INTEGER PRIMARY KEY AUTOINCREMENT,"
                                             "title TEXT,"
                                             "author TEXT,"
                                             "cover_img TEXT,"
                                             "src TEXT,"
                                             "difficulty INTEGER,"
                                             "numwords INTEGER,"
                                             "numpages INTEGER,"
                                             "publication_timestamp TIMESTAMP DEFAULT (DATETIME('now','localtime')),"
                                             "create_timestamp TIMESTAMP DEFAULT (DATETIME('now','localtime'))"
                                             ");";
        [db open];
        [db executeUpdate:sql];
        [db close];
        
        
        // insert test book
        sql=@"insert into books values (NULL,"
                                        "'Thackerayana Notes and Anecdotes', "
                                        "'Thackeray, William Makepeace, 1811-1863',"
                                        "'',"
                                        "'44563',"
                                        "3,"
                                        "10000,"
                                        "300,"
                                        "NULL, NULL);";
        
        [db open];
        [db executeUpdate:sql];
        [db close];

    }
}

@end
