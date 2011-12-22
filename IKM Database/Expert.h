//
//  Expert.h
//  IKM Database
//
//  Created by Michael Mühlebach on 11/11/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expert : NSObject


@property (strong, nonatomic) NSNumber* guid;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* careerLevel;
@property (strong, nonatomic) NSString* residence;
@property (strong, nonatomic) NSString* imageURLString;
@property (strong, nonatomic) NSString* businessUnitName;
@property (strong, nonatomic) UIImage* image;


+(id)expertWithFirstName:(NSString*)firstName LastName:(NSString*)lastName;

@end
