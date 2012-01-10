//
//  QueryParameter.h
//  IKM Database
//
//  Created by Michael Mühlebach on 1/9/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryParameter : NSObject {
    NSMutableArray* queryValues;
}

-(NSString*)queryName;
-(NSArray*)queryValues;
-(void)addQueryValue:(id)value;

-(NSString*)queryString;

@end
