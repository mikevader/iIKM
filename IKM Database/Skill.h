//
//  Skill.h
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Skill : NSObject
{
}

@property (strong, nonatomic) NSString* guid;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* preference;
@property (strong, nonatomic) NSNumber* projectsCount;
@property (strong, nonatomic) NSDate* projectsDuration;
@property (strong, nonatomic) NSString* comment;

+(id)skillWithId:(NSNumber*)number andName:(NSString*)name;


@end
