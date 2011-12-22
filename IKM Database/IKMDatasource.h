//
//  IKMDatasource.h
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Skill.h"

@protocol SkillDownloaderDelegate;

@interface IKMDatasource : NSObject

@property (strong, nonatomic) NSURLConnection *skillConnection;
@property (nonatomic, assign) id <SkillDownloaderDelegate> delegate;
@property (nonatomic, retain) NSMutableData *activeDownload;


-(void)startDownloadSkills;
-(NSSet*)listAllExpertsForSkill:(NSNumber*)skillGuid;
- (void)handleError:(NSError *)error;

@end

@protocol SkillDownloaderDelegate 

- (void)skillsDidLoad:(NSArray *)skills;

@end