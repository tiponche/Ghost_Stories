//
//  GhostViewController.m
//  GhostNav
//
//  Created by DGM59 on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GhostViewController.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "SoundManager.h"
#define kNumberOfItemsToAdd 25

@class SoundManager;

@implementation GhostViewController
@synthesize arrayFromData, storyObjectDictionary;
@synthesize imageThumb;
@synthesize urlCenter;
@synthesize pageNumber, countAll, numberToDisplay;
@synthesize receivedData, myNewArray;
@synthesize player;
@synthesize audioObject;

- (void)dealloc {
    self.audioObject = nil;
    self.player = nil;
    self.myNewArray = nil;
    self.receivedData = nil;
    self.urlCenter = nil;
    self.imageThumb = nil;
    self.storyObjectDictionary = nil;
    self.arrayFromData = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Ghost Story!!";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IOHostAudio *newAudioObject = [[[IOHostAudio alloc] init] autorelease];
	self.audioObject = newAudioObject;
    
//    [self.view reloadInputViews];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    self.numberToDisplay = kNumberOfItemsToAdd;
    self.countAll = kNumberOfItemsToAdd;
    self.pageNumber = 1;
    self.receivedData = [[NSMutableData data] retain];
    [self getArrayFromLoadMore];
}

//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.player = [[[SoundManager alloc] init] autorelease];
//    [self.player playAudio];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [self.player stopAudio];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.arrayFromData count] != (kNumberOfItemsToAdd * self.pageNumber)) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.countAll;
    } else {
        return 1;
    }    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            }
            
            if (indexPath.section == 0) {
                if (indexPath.row < self.countAll) {
                    NSLog(@"%d", [self.arrayFromData count]);
                    self.storyObjectDictionary = [self.arrayFromData objectAtIndex:indexPath.row];
                    NSDictionary *story = [self.storyObjectDictionary objectForKey:@"story"];
                    
                    cell.imageView.image = [self getImageThumb];
                    cell.textLabel.text = [story objectForKey:@"name"];
                    cell.detailTextLabel.text = [story objectForKey:@"story_snippet"];
                }
            } 
            
            else {  //in section 1 (LoadMore)
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadMore"] autorelease];
                cell.textLabel.text = @"Load More..";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
            }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 58;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSLog(@"Load More requested..");
        
        self.pageNumber += 1;
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        [HUD showWhileExecuting:@selector(self) onTarget:self withObject:nil animated:YES];
        
        [self getArrayFromLoadMore];
    
// Scroll the cell to the top of the table
            if ([self.myNewArray count] < kNumberOfItemsToAdd) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 200000000), dispatch_get_main_queue(), ^(void){
                    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.countAll - [self.myNewArray count]) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    NSLog(@"newarray<25 ::%d, %d", self.countAll, [self.myNewArray count]);
                });
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 200000000), dispatch_get_main_queue(), ^(void){
                    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.countAll - [self.myNewArray count]) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    NSLog(@"newarray=25 ::%d, %d", self.countAll, [self.myNewArray count]);
                });
            }            
            
//            [self.tableView setUserInteractionEnabled:NO];
        NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
        if (selection) {
            [self.tableView deselectRowAtIndexPath:selection animated:YES];
        }
        
    } else {
        NSLog(@"Normal cell selected");  

        self.storyObjectDictionary = [self.arrayFromData objectAtIndex:indexPath.row];
        NSDictionary *story = [self.storyObjectDictionary objectForKey:@"story"];
    
        DetailViewController1 *detailViewController1 = [[[DetailViewController1 alloc] init] autorelease];
        detailViewController1.aStory = story;
        detailViewController1.title = [story objectForKey:@"name"];
        [self.navigationController pushViewController:detailViewController1 animated:YES];
    }
}

- (UIImage *)getImageThumb
{
    NSDictionary *story = [self.storyObjectDictionary objectForKey:@"story"];
    NSString *imageURL = [story objectForKey:@"image_thumb"];
    NSString *pngString = [imageURL stringByReplacingOccurrencesOfString:@"/media" withString:@""];
    
    self.imageThumb = [self loadImage:pngString];
    
    if (self.imageThumb == NULL) {
        
        NSString *imageThumbString = [NSString stringWithFormat:@"%@%@", [URLCenter hostURL], imageURL];
        NSURL *imageThumbURL = [NSURL URLWithString:imageThumbString];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageThumbURL]];

        [self saveImage:image :pngString];
        return image;

    } else {
        self.imageThumb = [self loadImage: pngString];
        return self.imageThumb;
    }
}

- (void)saveImage: (UIImage *)image: (NSString *)pngString {

    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Documents/%@", pngString]];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
}

- (UIImage *)loadImage: (NSString *)pngString {                                                                                                                                          

    NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Documents/%@", pngString]];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];

    if (image == NULL) {
        image = NULL;
    }  
    else {
        NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Documents/%@", pngString]];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    return image;
}


// method from URLCenterDelegate
+ (NSString *)hostURL {
    return [URLCenter hostURL];
}

- (void)getArrayFromLoadMore {
    
        
    NSString *hostWithIndex = [[[NSString alloc] init] autorelease];
    hostWithIndex = [NSString stringWithFormat:@"%@/stories.json?page=%i", [URLCenter hostURL], self.pageNumber];
    NSLog(@"pageNumber::%i", self.pageNumber);
    
    NSLog(@"url from getmorearray:: %@", hostWithIndex);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:hostWithIndex]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        self.receivedData = [[NSMutableData data] retain];
    }

}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.receivedData setLength:0];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    [self.receivedData appendData:data];  

}

- (void)connection:(NSURLConnection *)connection

  didFailWithError:(NSError *)error

{
    [connection release];
    [self.receivedData release];
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading: (NSURLConnection *)connection
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"Succeeded! Received %d bytes of data",[self.receivedData length]);
    if (self.arrayFromData == NULL) {
        self.myNewArray = [self.receivedData objectFromJSONData];
        self.arrayFromData = [self.receivedData objectFromJSONData];
    } else {
        self.myNewArray = [self.receivedData objectFromJSONData];
        self.countAll = (kNumberOfItemsToAdd *self.pageNumber) - kNumberOfItemsToAdd + [self.myNewArray count];
        
        self.arrayFromData = (NSMutableArray *)[self.arrayFromData arrayByAddingObjectsFromArray:self.myNewArray];
//        [self.arrayFromData addObjectsFromArray:self.myNewArray];
    }

    [self.tableView reloadData];

    [connection release];
}

@end
