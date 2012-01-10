//
//  QueryParameter.m
//  IKM Database
//
//  Created by Michael Mühlebach on 1/9/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import "QueryParameter.h"

@implementation QueryParameter


-(id)init
{
    queryValues = [[NSMutableArray alloc] init];
    
    self = [super init];
    return self;
}

-(NSString*)queryName
{
    return nil;
}

-(NSArray*)queryValues
{
    return queryValues;
}

-(void)addQueryValue:(id)value
{
    [queryValues addObject:value];
}

-(NSString *)queryString
{
    NSString* queryString = nil;
    NSString* valueString = [NSString stringWithString:@""];
    
    for (NSString* value in [self queryValues]) {
        [valueString stringByAppendingString:value];
        [valueString stringByAppendingString:@","];
    }
    
    queryString = [NSString stringWithFormat:@"%@={%@}", [self queryName], valueString];
    
    return queryString;
}

@end
