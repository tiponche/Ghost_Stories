//
//  DetailViewController.m
//  GhostNav
//
//  Created by DGM59 on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "GhostViewController.h"
#import "JSONKit.h"

@implementation DetailViewController
@synthesize aStory, detail;

-(void)dealloc
{
    self.detail = nil;
    self.aStory = nil;
    [super dealloc];
}

-(void)viewDidLoad
{
//    DetailViewController *detailViewController = [[[DetailViewController alloc] init] autorelease];
    
    NSString *hostWithIndex = [[[NSString alloc] init] autorelease];
    hostWithIndex = [NSString stringWithFormat:@"%@stories/%@.json", [URLCenter hostURL], [aStory objectForKey:@"id"]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hostWithIndex]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSURLResponse *response;
	NSError *error = [[NSError alloc] init];
    NSData *rawData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];   
    NSDictionary *story = [rawData objectFromJSONData];
    NSDictionary *storyDetail = [story objectForKey:@"story"];
    NSLog(@"storyDetail date, source: %@, %@", [storyDetail objectForKey:@"date"], [storyDetail objectForKey:@"source"]);

    self.detail = [[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 270)] autorelease];
    self.detail.text = [storyDetail objectForKey:@"story"];
    NSLog(@"%@", self.detail.text);
}

@end
