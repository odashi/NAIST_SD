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
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myCollectionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [myCollectionView setDataSource:self];
    [myCollectionView setDelegate:self];
    myCollectionView.backgroundColor = [UIColor whiteColor];
    [self initDB];
    books = [Book getAllBooks];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    books = [Book getAllBooks];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
    [toolbar sizeToFit];
    [self.view addSubview:toolbar];

    NSArray *arr = [NSArray arrayWithObjects:@"Shelf", @"List", nil];
    UISegmentedControl *seg =
    [[UISegmentedControl alloc] initWithItems:arr];
    seg.frame = CGRectMake(510, 30, 250, 30);
    seg.selectedSegmentIndex = 0;
    seg.momentary = YES;
    
    [seg addTarget:self action:@selector(list:)
  forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    tv = [[TableViewController alloc] init];
    tv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    tv.view.backgroundColor = [UIColor whiteColor];
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
//        sql=@"insert into books values (NULL,"
//                                        "'Thackerayana Notes and Anecdotes', "
//                                        "'Thackeray, William Makepeace, 1811-1863',"
//                                        "'',"
//                                        "'44563',"
//                                        "9,"
//                                        "10000,"
//                                        "300,"
//                                        "NULL, NULL);";

        dbook = [NSMutableDictionary dictionary];
        [self setXMLParser];

        sql= [NSString stringWithFormat:@"insert into books values (NULL,"
        "'%@', "
        "'%@',"
        "'%@',"
        "'%@',"
        "%@,"
        "%@,"
        "%@,"
        "NULL,"
        "NULL"
        ");",
        dbook[@"title"],
        dbook[@"author"],
        dbook[@"cover_img"],
        dbook[@"src"],
        dbook[@"difficulty"],
        dbook[@"numwords"],
        dbook[@"numpages"]];

        NSLog(@"%@",sql);
        [db open];
        [db executeUpdate:sql];
        [db close];
    }
}

#pragma mark -collection view delegate



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else{
        return 0;
    }
}

//Method to create cell at index path
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;

    if(indexPath.section==0){//セクション0のセル
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];

        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        NSString *path = [bundle pathForResource:@"testimg" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        UIImageView *iv = [[UIImageView alloc] init];
        iv.backgroundColor = [UIColor blueColor];
        iv.frame = CGRectMake(10.0, 10.0, 142.0, 216.0);
        iv.image =[UIImage imageWithContentsOfFile:path];

        [cell addSubview:iv];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,200,142,12)];
//        NSString *str1 = [[NSString stringWithFormat:@"%d",[books objectAtIndex:indexPath.item].difficulty]];
//        label.text = str1;
        label.font = [UIFont fontWithName:@"AppleGothic" size:12];
        label.textColor = [UIColor whiteColor];
        [cell addSubview:label];
        
//        UIImageView *image = (UIImageView *)[cell viewWithTag:2];
//        image.backgroundColor = [UIColor blueColor];
        //        image.image = books[indexPath.load].cover_img);
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // set and show epub view controler
    EpubViewController *ev = [[EpubViewController alloc] init];
    [ev setBook: [books objectAtIndex:indexPath.item]];
    [self presentViewController:ev animated:YES completion:nil];
}


-(void)list:(UISegmentedControl*)seg
{
    [self presentViewController:tv animated:YES completion:nil];
}




- (void)setXMLParser
{
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    NSString* path = [bundle pathForResource:@"pg44563" ofType:@"xml"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //解析中タグの初期化
    nowTagStr = @"";
}

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
    if ( [elementName isEqualToString:@"title"] ){
        nowTagStr = [NSString stringWithString:elementName];
    }
    else if([elementName isEqualToString:@"author"]){
        nowTagStr = [NSString stringWithString:elementName];
    }
    else if([elementName isEqualToString:@"cover_img"]){
        nowTagStr = [NSString stringWithString:elementName];
    }
    else if([elementName isEqualToString:@"src"]){
        nowTagStr = [NSString stringWithString:elementName];
    }
    else if([elementName isEqualToString:@"difficulty"]){
        nowTagStr = [NSString stringWithString:elementName];
    }
    else if([elementName isEqualToString:@"numwords"]){
        nowTagStr = [NSString stringWithString:elementName];
    }
    else if([elementName isEqualToString:@"numpages"]){
        nowTagStr = [NSString stringWithString:elementName];
    }
    else if([elementName isEqualToString:@"publication_timestamp"]){
        nowTagStr = [NSString stringWithString:elementName];
    }
    else if([elementName isEqualToString:@"create_timestamp"]){
        nowTagStr = [NSString stringWithString:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([nowTagStr isEqualToString:@"title"]) {
        [dbook setObject:string forKey:@"title"];
    }
    else if ([nowTagStr isEqualToString:@"author"]) {
        [dbook setObject:string forKey:@"author"];
    }
    else if ([nowTagStr isEqualToString:@"cover_img"]) {
        [dbook setObject:string forKey:@"cover_img"];
    }
    else if ([nowTagStr isEqualToString:@"src"]) {
        [dbook setObject:string forKey:@"src"];
    }
    else if ([nowTagStr isEqualToString:@"difficulty"]) {
        [dbook setObject:string forKey:@"difficulty"];
    }
    else if ([nowTagStr isEqualToString:@"numwords"]) {
        [dbook setObject:string forKey:@"numwords"];
    }
    else if ([nowTagStr isEqualToString:@"numpages"]) {
        [dbook setObject:string forKey:@"numpages"];
    }
    else if ([nowTagStr isEqualToString:@"publication_timestamp"]) {
        [dbook setObject:string forKey:@"publication_timestamp"];
    }
    else if ([nowTagStr isEqualToString:@"create_timestamp"]) {
        [dbook setObject:string forKey:@"create_timestamp"];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"book"]) {
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"title"] ){
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"author"] ){
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"cover_img"] ){
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"src"] ){
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"difficulty"] ){
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"numwords"] ){
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"numpages"] ){
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"publication_timestamp"] ){
        nowTagStr = @"";
    }
    else if ( [elementName isEqualToString:@"create_timestamp"] ){
        nowTagStr = @"";
    }
}






@end