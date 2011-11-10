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

@class URLCenter;
@implementation GhostViewController
@synthesize arrayFromData, storyObjectDictionary;

- (void)dealloc {
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
    NSLog(@"%@", [URLCenter hostURL]);

    
    NSString *hostWithIndex = [[[NSString alloc] init] autorelease];
    hostWithIndex = [NSString stringWithFormat:@"%@stories.json?page=1", [URLCenter hostURL]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hostWithIndex]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSURLResponse *response;
	NSError *error = [[NSError alloc] init];
    NSData *rawData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];   
    self.arrayFromData = [rawData objectFromJSONData];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    if ( [self.arrayFromData count] == 25 ) {
        return [self.arrayFromData count] + 1;
    } 
    else {
        return [self.arrayFromData count];
    } 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSLog(@"%d, total %d", indexPath.row, [arrayFromData count]);
    
    UITableViewCell *cell; //= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row != [self.arrayFromData count] ) 
    {
// As long as we haven’t reached the +1 yet in the count, we populate the cell like normal
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
    
    // Configure the cell...
        self.storyObjectDictionary = [self.arrayFromData objectAtIndex:indexPath.row];
        NSDictionary *story = [self.storyObjectDictionary objectForKey:@"story"];

//begins to load image direct from host (effected slow loading on device)
        NSString *imageURL = [NSURL URLWithString:[story objectForKey:@"image_thumb"]];
        NSString *address = [NSString stringWithFormat:@"%@%@", [URLCenter hostURL], imageURL]; 
        NSURL *url = [NSURL URLWithString:address];
        NSData *data = [NSData dataWithContentsOfURL:url];  
        cell.imageView.image = [UIImage imageWithData:data];
//end loading image
    
        cell.textLabel.text = [story objectForKey:@"name"];
        cell.detailTextLabel.text = [story objectForKey:@"story_snippet"];
    }
    
    else
    {
// Here we create the ‘Load more’ cell
        if(indexPath.row == [self.arrayFromData count]) 
        { 
            NSLog(@"adding it here");
            cell = [tableView dequeueReusableCellWithIdentifier:@"Load"];
        // Here we check if we reached the end of the index, so the +1 row
            if (cell == nil) 
            {   
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Load"] autorelease];
            }
//            if (cell == nil) 
//            {
//                cell = [[[ImageCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
//            }
            // Reset previous content of the cell, I have these defined in a UITableCell subclass, change them where needed
//            cell.cellBackground.image = nil;
//            cell.titleLabel.text = nil;
            
            // Here we create the ‘Load more’ cell
//            UILabel *loadMore = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, loadMore.frame.size.width, loadMore.frame.size.height)];
            UILabel *loadMore = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, 350, 40)];
            loadMore.textColor = [UIColor blackColor];
            loadMore.highlightedTextColor = [UIColor darkGrayColor];
            loadMore.backgroundColor = [UIColor clearColor];
            loadMore.textAlignment = UITextAlignmentCenter;
//            loadMore.font=[UIFont boldSystemFontOfSize:20];
            loadMore.text=@"Load More..";
            [cell addSubview:loadMore];
        }   
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
//	NSString *sectionHeader = nil;
	
    NSString *sectionHeader = @"Ghost Storiessssss..";

	return sectionHeader;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [self.arrayFromData count] == 25 ) { //  Only call the function if we have 25 results in the array
        if (indexPath.row == [self.arrayFromData count] ) {
            NSLog(@"Load More requested"); // Add a function here to add more data to your array and reload the content
        } else {
            NSLog(@"Normal cell selected"); // Add here your normal didSelectRowAtIndexPath code
        }
    } else {
        NSLog(@"Normal cell selected with < 25 results"); //  Add here your normal didSelectRowAtIndexPath code
    }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
