//
//  ExpertDetailTableViewController.h
//  skilldb
//
//  Created by Michael Mühlebach on 1/25/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpertDetailTableViewController : UIViewController <UITableViewDelegate> {
    UITableView* tableView;
    id<UITableViewDataSource> dataSource;
}

@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) id<UITableViewDataSource> dataSource;

- (id)initWithDataSource:(id<UITableViewDataSource>)theDataSource andTable:(UITableView*)theTableView;


@end
