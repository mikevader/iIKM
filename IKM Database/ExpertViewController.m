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

#define DetailCellIdentifier @"DetailCell"

enum {
    DetailSection,
    ExpertDetailSectionCount
} ExpertDetailSections;

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


// UITableViewController

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ExpertDetailSectionCount;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case DetailSection:
            return @"Details";
            break;
            
        default:
            return nil;
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case DetailSection:
            return 3;
            break;
            
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:DetailCellIdentifier];
    }
    
    
    NSString* text = nil;
    NSString* label = nil;
    
    switch (indexPath.section) {
        case DetailSection:
            switch (indexPath.row) {
                case 0:
                    label = @"BU";
                    text = expert.businessUnitName;
                    break;
                case 1:
                    label = @"Level";
                    text = expert.careerLevel;
                    break;
                case 2:
                    label = @"Location";
                    text = expert.residence;
                    break;
                case 3:
                    label = @"Username";
                    text = expert.username;
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    cell.detailTextLabel.text = text;
    cell.textLabel.text = label;
    
    return cell;
}

@end
