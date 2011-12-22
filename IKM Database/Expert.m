//
//  Expert.m
//  IKM Database
//
//  Created by Michael Mühlebach on 11/11/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import "Expert.h"

@implementation Expert

@synthesize guid;
@synthesize firstName;
@synthesize lastName;
@synthesize username;
@synthesize careerLevel;
@synthesize residence;
@synthesize imageURLString;
@synthesize businessUnitName;
@synthesize image;

+(id)expertWithFirstName:(NSString*)firstName LastName:(NSString*)lastName
{
    Expert* expert = [[Expert alloc] init];
    expert.firstName = firstName;
    expert.lastName = lastName;
    
    return expert;
}


@end
