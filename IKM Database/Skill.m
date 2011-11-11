//
//  Skill.m
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import "Skill.h"

@implementation Skill

@synthesize guid;
@synthesize name;
@synthesize preference;
@synthesize projectsCount;
@synthesize projectsDuration;
@synthesize comment;


-(id)init
{
    self = [super init];
    return self;
}

+(id)skillWithId:(NSNumber*)number andName:(NSString*)name
{
    Skill* skill = [[Skill alloc] init];
    skill.guid = number;
    skill.name = name;
    
    return skill;
}

@end
