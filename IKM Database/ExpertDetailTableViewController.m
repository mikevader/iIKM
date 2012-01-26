//
//  ExpertDetailTableViewController.m
//  skilldb
//
//  Created by Michael Mühlebach on 1/25/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import "ExpertDetailTableViewController.h"

@implementation ExpertDetailTableViewController

@synthesize tableView, dataSource;

-(id)initWithDataSource:(id<UITableViewDataSource>)theDataSource andTable:(UITableView*)theTableView
{
    if ([self init]) {
        self.tableView = theTableView;
        self.dataSource = theDataSource;
    }
    
    return self;
}

-(void)dealloc {
    tableView = nil;
    dataSource = nil;
}

-(void)loadView {
    
    tableView.delegate = self;
    tableView.dataSource = dataSource;
    self.view = tableView;
}


-(void)viewWillAppear:(BOOL)animated {
    [tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
