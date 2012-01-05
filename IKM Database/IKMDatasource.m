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

@synthesize skillConnection;
@synthesize delegate;
@synthesize activeDownload;

NSMutableSet* skills;


-(id)init
{
    self = [super init];
    skills = [[NSMutableSet alloc] init];
    return self;
}

-(void)startDownloadSkills
{
    NSString* urlString = @"http://localhost:8084/ikm/skill";
    self.activeDownload = [NSMutableData data];
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    skillConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON String %@", jsonString);
    [self.activeDownload appendData:data];
}

// -------------------------------------------------------------------------------
//	connectionDidFinishLoading:connection
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.skillConnection = nil;   // release our connection
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   

    NSError* jsonParsingError = nil;
    NSDictionary* skillArray = [NSJSONSerialization JSONObjectWithData:self.activeDownload options:0 error:&jsonParsingError];
    self.activeDownload = nil;
    
    if (jsonParsingError) {
        [self handleError:jsonParsingError];
    }
    else
    {
        for (NSDictionary* dict in [skillArray objectForKey:@"skills"]) {
            
            NSNumber* guid = [NSNumber numberWithInt:[[dict objectForKey:@"guid"] intValue]];
            NSString* name = [dict objectForKey:@"name"];
            NSString* comment = [dict objectForKey:@"comment"];
            
            Skill* skill = [Skill skillWithId:guid andName:name];
            skill.comment = comment;
            
            [skills addObject:skill];
            
            NSLog(@"Added: %@", [dict description]);
        }
    }

    [skills addObject:[Skill skillWithId:[NSNumber numberWithInt:5] andName:@"JavaEE"]];
    [skills addObject:[Skill skillWithId:[NSNumber numberWithInt:6] andName:@"NetBeans"]];
    
    
    [delegate skillsDidLoad:[skills allObjects]];
}

- (BOOL)isActiveDownload
{
    return self.activeDownload != nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
															 forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
        [self handleError:noConnectionError];
    }
	else
	{
        // otherwise handle the error generically
        [self handleError:error];
    }
    
    self.skillConnection = nil;   // release our connection
}


// -------------------------------------------------------------------------------
//	handleError:error
// -------------------------------------------------------------------------------
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can not load skills from IKM."
														message:errorMessage
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
    [alertView show];
}





-(NSSet*)listAllExpertsForSkill:(NSNumber*)skillGuid
{
    NSMutableSet* experts = [[NSMutableSet alloc] init];
    
    [experts addObject:[Expert expertWithFirstName:@"Michael" LastName:@"Mühlebach"]];
    
    return experts;
}

@end
