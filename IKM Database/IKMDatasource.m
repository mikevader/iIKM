//
//  IKMDatasource.m
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import "IKMDatasource.h"
#import "Skill.h"

@implementation IKMDatasource

-(id)init
{
    self = [super init];
    return self;
}

-(NSSet*)retreiveAllSkills
{
    NSMutableSet* skills = [[NSMutableSet alloc]init];
    
    [skills addObject:[Skill skillWithId:[NSNumber numberWithInt:5] andName:@"JavaEE"]];
    [skills addObject:[Skill skillWithId:[NSNumber numberWithInt:6] andName:@"NetBeans"]];
    
    return skills;
}

@end
