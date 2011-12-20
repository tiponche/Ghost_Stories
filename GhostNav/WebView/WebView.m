//
//  WebView.m
//  GhostNav
//
//  Created by DGM59 on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WebView.h"
#import "DetailViewController1.h"
#import "MBProgressHUD.h"

@implementation WebView

@synthesize myWebView, webString;

- (void)dealloc {
    self.webString = nil;
    self.myWebView = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    NSString *urlAddress = [NSString stringWithFormat:@"http://%@/", self.webString];
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];

    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [MBProgressHUD showHUDAddedTo:self.myWebView animated:YES];     
    [self.myWebView loadRequest:request];
    [self.view addSubview:self.myWebView];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [MBProgressHUD hideHUDForView:self.myWebView animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

@end
