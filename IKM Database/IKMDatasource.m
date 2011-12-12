//
//  IKMDatasource.m
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import "IKMDatasource.h"
#import "Skill.h"
#import "Expert.h"

@implementation IKMDatasource

NSMutableSet* skills;

-(id)init
{
    self = [super init];
    skills = [[NSMutableSet alloc] init];
    return self;
}

-(NSSet*)retreiveAllSkills
{
    NSString* urlString = @"http://localhost:8084/ikm/skill";
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [skills addObject:[Skill skillWithId:[NSNumber numberWithInt:5] andName:@"JavaEE"]];
    [skills addObject:[Skill skillWithId:[NSNumber numberWithInt:6] andName:@"NetBeans"]];
    
    return skills;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON String %@", jsonString);
    
    NSError* jsonParsingError = nil;
    NSDictionary* skillArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];

    for (NSDictionary* dict in [skillArray objectForKey:@"skills"]) {
        
        NSNumber* guid = [NSNumber numberWithInt:[[dict objectForKey:@"guid"] intValue]];
        NSString* name = [dict objectForKey:@"name"];
        NSString* comment = [dict objectForKey:@"comment"];
        
        
        [skills addObject:[Skill skillWithId:guid andName:name]];
        
        NSLog(@"Added: %@", [dict description]);
    }
}




-(NSSet*)listAllExpertsForSkill:(NSNumber*)skillGuid
{
    NSMutableSet* experts = [[NSMutableSet alloc] init];
    
    [experts addObject:[Expert expertWithFirstName:@"Michael" LastName:@"Mühlebach"]];
    
    return experts;
}

@end
