//
//  ExpertDetailTableDataSource.m
//  skilldb
//
//  Created by Michael Mühlebach on 1/25/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import "ExpertDetailTableDataSource.h"



@implementation ExpertDetailTableDataSource

NSString* const CellName = @"DetailCell";






// UITableViewDataSource methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AtomicElementTableViewCell"];
	}

    cell.detailTextLabel.text = @"thisIs:";
    cell.textLabel.text = @"ooooood";
	
	return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return [[NSArray alloc] initWithObjects:@"Title", @"Second Title", nil];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return index;
}


- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Super Title";
}

@end
