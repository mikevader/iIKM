//
//  SkillTableViewController.h
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKMDatasource.h"
#import "ExpertTableViewController.h"

@interface SkillTableViewController : UITableViewController<SkillDownloaderDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
{
    IKMDatasource* ikmWrapper;
    
}
@property (strong, nonatomic) NSArray* skills;
@property (strong, nonatomic) NSMutableArray* filteredSkills;
@property (weak, nonatomic) IBOutlet UISearchBar* uiSearchBar;


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
- (void)filterContentForSearchText:(NSString*)searchText;

@end
