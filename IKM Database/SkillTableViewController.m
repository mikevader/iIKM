//
//  SkillTableViewController.m
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import "SkillTableViewController.h"
#import "SkillQuery.h"


@implementation SkillTableViewController

@synthesize skills;
@synthesize filteredSkills;
@synthesize uiSearchBar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (nil == ikmWrapper)
    {
        ikmWrapper = [[IKMDatasource alloc] init];
    }
    
    ikmWrapper.delegate = self;
    [ikmWrapper startDownloadSkills];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.filteredSkills = nil;
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
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
    /*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
    int count = [self.filteredSkills count];
    
    if ([ikmWrapper isActiveDownload])
    {
        return 1;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *skillCellIdentifier = @"SkillCell";
    static NSString *placeholderCellIdentifier = @"PlaceholderCell";

    
    // Add placeholder cell while waiting on table data
    UITableViewCell *cell = nil;
    
    if ([ikmWrapper isActiveDownload])
    {
        cell = [tableView dequeueReusableCellWithIdentifier:placeholderCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeholderCellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        UILabel* label = (UILabel*)[cell viewWithTag:100];
        label.text = @"Loading...";
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:skillCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:skillCellIdentifier];
            //		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

        Skill* skill = nil;
        skill = [self.filteredSkills objectAtIndex:indexPath.row];
        
        // Configure the cell...
        UILabel* label = (UILabel*)[cell viewWithTag:100];
        label.text = skill.name;
    }
    
    return cell;
}

- (void)skillsDidLoad:(NSArray *)skills
{
    self.skills = nil;
    self.skills = skills;
    
    self.skills = [self.skills sortedArrayUsingComparator:^(id obj1, id obj2) {
        NSComparisonResult result = [[obj1 name] compare:[obj2 name]];
        
        return result;
    }];
    
    self.filteredSkills = [NSMutableArray arrayWithArray:self.skills];
    
    [self.tableView reloadData];
}

- (IBAction)reloadFromServer:(id)sender {
    [ikmWrapper startDownloadSkills];
}

#pragma mark -
#pragma mark Content Filtering


- (void)filterContentForSearchText:(NSString*)searchText
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredSkills removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (Skill *skill in self.skills)
	{
        NSRange result = [skill.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (searchText == nil || [searchText isEqualToString:@""] || result.location != NSNotFound)
        {
            [self.filteredSkills addObject:skill];
		}
	}
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText];
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString* searchText = searchBar.text;
    
    [self filterContentForSearchText:searchText];
    [self.tableView reloadData];
    
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowExpert"])
    {
        ExpertTableViewController* expertViewController = segue.destinationViewController;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        Skill* skill = [self.filteredSkills objectAtIndex:indexPath.row];
        SkillQuery* skillQuery = [SkillQuery skillQueryWithSkillId:skill.guid];
        expertViewController.queries = [NSArray arrayWithObject:skillQuery];
    }
}

@end
