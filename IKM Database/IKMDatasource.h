//
//  IKMDatasource.h
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Skill.h"

@interface IKMDatasource : NSObject

-(NSSet*)retreiveAllSkills;
-(NSSet*)listAllExpertsForSkill:(NSNumber*)skillGuid;

@end
