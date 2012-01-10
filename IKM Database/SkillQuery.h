//
//  SkillQuery.h
//  IKM Database
//
//  Created by Michael Mühlebach on 1/9/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import "QueryParameter.h"

@interface SkillQuery : QueryParameter

+(SkillQuery*)skillQueryWithSkillId:(NSString*)skillId;

@end
