//
//  ExpertTableViewController.h
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Skill.h"
#import "Expert.h"
#import "FirstViewController.h"
#import "IKMDatasource.h"
#import "ImageDownloader.h"

@interface ExpertTableViewController : UITableViewController<ImageDownloaderDelegate>

@property (strong, nonatomic) Skill* skill;
@property (strong, nonatomic) NSArray* experts;
@property (strong, nonatomic) NSMutableDictionary* imageDownloadsInProgress;

- (void)startIconDownload:(Expert *)expert forIndexPath:(NSIndexPath *)indexPath;
@end
