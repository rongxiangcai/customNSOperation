//
//  MyTableViewController.m
//  CustomNSOperation
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 JCKJ. All rights reserved.
//

#import "MyTableViewController.h"
#import "YYdownLoadOperation.h"

@interface MyTableViewController () <UITableViewDataSource, UITableViewDelegate, YYdownLoadOperationDelegate>

@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) NSOperationQueue *queue;
@property(nonatomic,strong)NSMutableDictionary *operations;
@property(nonatomic,strong)NSMutableDictionary *images;
@end

@implementation MyTableViewController
- (NSMutableDictionary *)operations{
    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    return  _operations;
}

- (NSMutableDictionary *)images{
    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _operations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSLog(@"%lu",self.urls.count);
    return self.urls.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"hehe";
    cell.detailTextLabel.text = @"haha";
//    cell.imageView.frame = CGRectMake(0, 0, 180, 180);
    
    UIImage *image = self.images[self.urls[indexPath.row]];
    if (image) {
        cell.imageView.image = image;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"tupian_01"];
        YYdownLoadOperation *operation = self.operations[self.urls[indexPath.row]];
        if (operation) {
            
        }else{
            operation = [[YYdownLoadOperation alloc] init];
            operation.url = self.urls[indexPath.row];
            operation.indexPath = indexPath;
            operation.delegate = self;
            [self.queue addOperation:operation];
            self.operations[self.urls[indexPath.row]] = operation;
        }
    }
    
//    YYdownLoadOperation *operation = [[YYdownLoadOperation alloc] init];
//    operation.url = self.urls[indexPath.row];
//    operation.indexPath = indexPath;
//    operation.delegate = self;
//    [self.queue addOperation:operation];
//    NSURL *url = [NSURL URLWithString:self.urls[indexPath.row]];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    
//    UIImage *image = [UIImage imageWithData:data];
//    cell.imageView.image = image;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;

}

- (NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}

- (NSArray *)urls{
    if (_urls == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tupianurl.plist" ofType:nil];
        NSDictionary *dict1 = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *array = dict1[@"urls"];
        _urls = array;
    }
    
    return _urls;
}

- (void)downLoadOperation:(YYdownLoadOperation *)operation didFishedDownLoad:(UIImage *)image{
    [self.operations removeObjectForKey:operation.url];
    self.images[operation.url] = image;
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:operation.indexPath];
//    cell.imageView.image = image;
//    [self.tableView reloadData];
    [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
