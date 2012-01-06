//
//  FirstViewController.m
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import "ExpertViewController.h"

@implementation ExpertViewController

@synthesize expert;
@synthesize expertName;
@synthesize careerLevel;
@synthesize businessUnit;
@synthesize picture;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    expertName.text = [NSString stringWithFormat:@"%@ %@", expert.firstName, expert.lastName];
    careerLevel.text = expert.careerLevel;
    businessUnit.text = expert.businessUnitName;
    
    if (expert.image == nil)
    {
        // if a download is deferred or in progress, return a placeholder image
        picture.image = [UIImage imageNamed:@"Placeholder.png"];
        ImageDownloader* loader = [[ImageDownloader alloc] init];
        loader.delegate = self;
        loader.expert = expert;
        
        [loader startDownload];
    }
    else
    {
        picture.image = expert.image;
    }
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


-(void)expertImageDidLoad:(NSIndexPath *)indexPath
{
    self.picture.image = expert.image;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
