//
//  TableViewController.m
//  grasphy
//
//  Created by yu.takagi on 2014/02/10.
//  Copyright (c) 2014年 NAIST_SD. All rights reserved.
//

#import "TableViewController.h"
#import "FMDatabase.h"
#import "EpubViewController.h"
#import "Book.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDB];
    books = [Book getAllBooks];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
    NSArray *arr_table = [NSArray arrayWithObjects:@"Shelf", @"List", nil];
    UISegmentedControl *seg_table =
    [[UISegmentedControl alloc] initWithItems:arr_table];
    seg_table.frame = CGRectMake(510, 30, 250, 30);
    seg_table.selectedSegmentIndex = 1;
    seg_table.momentary = YES;
    [seg_table addTarget:self action:@selector(shelf:)
        forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg_table];
    [toolbar addSubview:seg_table];
    [self.tableView setTableHeaderView:toolbar];
//    names=[NSArray arrayWithObjects:@"Adventures of Huckleberry Finn by Mark Twain",nil];
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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        Book  *abook = [books objectAtIndex: indexPath.row];    
        cell.textLabel.text = abook.title;
        cell.detailTextLabel.text = abook.author;
    }
    
    return cell;
}

-(void)shelf:(UISegmentedControl*)seg
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 768, 64)];
    //    header.backgroundColor = [UIColor blackColor];
    
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EpubViewController *ev = [[EpubViewController alloc] init];
    [ev setBook: [books objectAtIndex:indexPath.item]];
    [self presentViewController:ev animated:YES completion:nil];
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
