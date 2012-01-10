//
//  SkillQuery.m
//  IKM Database
//
//  Created by Michael Mühlebach on 1/9/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import "SkillQuery.h"

@implementation SkillQuery

+(SkillQuery*)skillQueryWithSkillId:(NSString*)skillId
{
    SkillQuery* skillQuery = [[SkillQuery alloc] init];
    [skillQuery addQueryValue:skillId];
    
    return skillQuery;
}

-(id)init
{
    self = [super init];
    return self;
}

-(NSString*)queryName
{
    return @"skillidlist";
}

@end
