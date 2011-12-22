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

@end
