//
//  DetailViewController1.m
//  GhostNav
//
//  Created by DGM59 on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController1.h"
#import "GhostViewController.h"
#import "JSONKit.h"
#import "WebView.h"

@class SoundManager;

@implementation DetailViewController1
@synthesize aStory;
@synthesize receivedData, webString;
@synthesize player;

-(void)dealloc
{
    self.player = nil;
    self.webString = nil;
    self.receivedData = nil;
    self.aStory = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.player = [[[SoundManager alloc] init] autorelease];
    [self.player playSecondAudio];    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *hostWithIndex = [[[NSString alloc] init] autorelease];
    hostWithIndex = [NSString stringWithFormat:@"%@/stories/%@.json", [URLCenter hostURL], [aStory objectForKey:@"id"]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hostWithIndex]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if (connection) {
        self.receivedData = [[NSMutableData data] retain];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player stopAudio];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSDictionary *story = [self.receivedData objectFromJSONData];
    NSDictionary *storyDetail = [story objectForKey:@"story"];
    
    NSString *imageFull = [NSURL URLWithString:[storyDetail objectForKey:@"image_full"]];
    NSString *imageFullString = [NSString stringWithFormat:@"%@/%@", [URLCenter hostURL], imageFull];
    NSURL *imageFullURL = [NSURL URLWithString:imageFullString];
    UIImageView *fullImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageFullURL]]];
    
    UILabel *dateLebel = [[UILabel alloc] initWithFrame:CGRectMake(0, fullImageView.image.size.height, 320, 17)];
    dateLebel.text = [NSString stringWithFormat:@"%@", [storyDetail objectForKey:@"date"]];
    dateLebel.font = [UIFont systemFontOfSize:13];
    dateLebel.textAlignment = UITextAlignmentRight;  
    
    UIButton *sourceLabel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sourceLabel.frame = CGRectMake(320 - 130, fullImageView.image.size.height + dateLebel.frame.size.height, 130, 22);    
//    UIButton *sourceLabel = [[UIButton alloc] initWithFrame:CGRectMake(0, fullImageView.image.size.height + dateLebel.frame.size.height, 320, 22)];
//    sourceLabel.titleLabel.text = [NSString stringWithFormat:@"%@", [storyDetail objectForKey:@"source"]];
    [sourceLabel setTitle:[NSString stringWithFormat:@"%@", [storyDetail objectForKey:@"source"]] forState:UIControlStateNormal];
    sourceLabel.titleLabel.font = [UIFont systemFontOfSize:13];  
    sourceLabel.titleLabel.textAlignment = UITextAlignmentRight;
    self.webString = [NSString stringWithFormat:@"%@", [storyDetail objectForKey:@"source"]];
    [sourceLabel addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextView *detailTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    detailTextView.editable = NO;
    detailTextView.text = [NSString stringWithFormat:@"\n\n\n\n\n\n\n\n\n\n\n\n%@", [storyDetail objectForKey:@"story"]];
    detailTextView.font = [UIFont systemFontOfSize:17];
    
    [detailTextView addSubview:fullImageView];        
    [detailTextView addSubview:dateLebel];
    [detailTextView addSubview:sourceLabel];
    [self.view addSubview:detailTextView];
//    [self.view addSubview:sourceLabel];
    
}

- (void)pushView:(id)sender {
    

    NSLog(@"CLicked");
    WebView *webView = [[[WebView alloc] init] autorelease];
    webView.webString = self.webString;
    webView.title = self.webString;
    [self.navigationController pushViewController:webView animated:YES];

}

@end
