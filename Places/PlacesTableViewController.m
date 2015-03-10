//
//  PlacesTableViewController.m
//  Places
//
//  Created by John Schindler on 3/3/15.
//  Copyright (c) 2015 John Schindler. All rights reserved.
//


#import "PlacesTableViewController.h"
#import "Flickrfetcher.h"
#import "Place.h"
#import "UIColor+FlatUI.h"
#import "ImageListTableViewController.h"


@interface PlacesTableViewController ()

//@property (strong, nonatomic) NSMutableArray* places;
@property (strong, nonatomic) NSMutableDictionary* places;

@end

@implementation PlacesTableViewController

-(NSMutableDictionary *) places{
    return !_places ? _places = [[NSMutableDictionary alloc] init] : _places;
}

-(void)viewWillAppear:(BOOL)animated{
    
    //block intially to load 100 random places
    //while(placeIds.count < 100){
    //int count = 0;
    while(self.places.count < 20){
    //while(count < 20){
        
        NSURL *url = [FlickrFetcher URLforRandomPlace];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSError *err = nil;
        NSDictionary *results;
        
        if(data)
            results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        else
            NSLog(@"data from flickr is null");
        
        for(id key in results){
            NSLog(@"Key: %@", key);
            NSLog(@"Value: %@", [results valueForKey:key]);
        }
            
        
        NSArray *placeInfo;
        if(results)
            placeInfo = [results valueForKeyPath:@"places.place"];
        
        //for(NSString *str in placeInfo)
        //NSLog(@"LINE: %@", str);
        
        Place *place = [[Place alloc] init];
        if(placeInfo){
            //NSLog(@"In placeInfo if the size is: %lu", placeInfo.count);
            
            for (NSDictionary *dataDict in placeInfo) {
                
                NSString *name = dataDict[@"name"];
                if([name isKindOfClass:[NSString class]]
                   ){
    
                    place.placeId = dataDict[@"woeid"];
                    //NSLog(@"Count: %d", count);
                    NSLog(@"Place: %@", dataDict[@"name"]);
                    NSString *placeString = dataDict[@"name"];
                    
                    NSArray *split = [placeString componentsSeparatedByString:@","];
                    place.City = split[0];
                    place.State = split[1];
                    if(split.count > 2)
                        place.Country = split[2];
                    else place.Country = @"";
                    
                    //for(NSString *str in split)
                        //NSLog(@"SPLIITER: %@", str);
                    
                    //NSArray* myArray = [myString  componentsSeparatedByString:@","];
                    NSString *numString = [NSString stringWithFormat:@"%lu", (unsigned long)self.places.count];
                    
                    //NSString *numString = [NSString stringWithFormat:@"%d", count];
                    [self.places setValue:place forKey:numString];
                    // count += 1;
                }
                
            }
        }
    }
    

    CGRect frame;
    CGSize size = {self.tableView.bounds.size.width, 60};
    frame.size = size;
    frame.origin.x = 0;
    frame.origin.y = 0;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [self.tableView setTableHeaderView:headerView];
    self.tableView.tableHeaderView.backgroundColor = [UIColor midnightBlueColor];
    
    CGRect textFrame;
    CGSize textSize = {25, 20};
    frame.size = textSize;
    frame.origin.x = 150;
    frame.origin.y = 20;

    UILabel *headerText = [[UILabel alloc] initWithFrame:textFrame];
    headerText.text = @"HEY";
    [self.tableView addSubview : headerText];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 100;
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Place Cell" forIndexPath:indexPath];
    NSString *numString = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    Place *place = [self.places objectForKey:numString];
    cell.textLabel.text = place.City;
    cell.backgroundColor = [UIColor greenSeaColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", place.State, place.Country];
    return cell;
    
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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     //if ([segue.destinationViewController isKindOfClass:[ImageListTableViewController class]]) {
        //if ([segue.destinationViewController isKindOfClass:[ImageListTableViewController class]]) {
            
            //ImageListTableViewController* listController = (ImageListTableViewController*) segue.destinationViewController;
            
             //UITableViewCell *cell = (UITableViewCell) sender;
             NSIndexPath *index = [self.tableView indexPathForCell:sender];
             NSInteger row = index.row;
             NSString *numString = [NSString stringWithFormat:@"%ld", (long)row];
             Place *place = [self.places objectForKey:numString];
             NSURL *url = [FlickrFetcher URLforPhotosInPlace: place.placeId maxResults:50];
             NSData *data = [NSData dataWithContentsOfURL:url];
             NSLog(@"%@", url);
             
             NSDictionary *results;
             if(url)
                 results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             else
                 NSLog(@"data from flickr is null");
             
             
             if(results){
                 NSLog(@"Results %lu", results.count);
      
                 for(id key in results)
                     NSLog(@"key: %@", key);
                 
                 NSDictionary *dict = [[NSMutableDictionary alloc] init];
                 dict = results[@"photos"];
                 NSLog(@"dict: %lu", dict.count);
           
                 NSDictionary *dict2 = [[NSMutableDictionary alloc] init];
                 dict2 = dict[@"photo"];
                 NSLog(@"dict2: %lu", dict2.count);
                 
                 //NSMutableDictionary* photos = results[FLICKR_RESULTS_PHOTOS];
                 //NSLog(@"photos: %lu", photos.count);
                 
                 
                 
             //}
         //}
         
     }
     
     
    
     
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


 

@end
