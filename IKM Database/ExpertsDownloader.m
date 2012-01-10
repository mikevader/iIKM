//
//  ExpertDownloader.m
//  IKM Database
//
//  Created by Michael Mühlebach on 1/5/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import "ExpertsDownloader.h"
#import "Expert.h"

@implementation ExpertsDownloader

@synthesize experts;
@synthesize delegate;
@synthesize activeDownload;
@synthesize connection;
@synthesize queries;

-(id)init
{
    self = [super init];
    experts = [[NSMutableArray alloc] init];
    return self;
}

-(void)startDownload
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* ikmServerUrl = [defaults stringForKey:@"IKMServerUrl"];
    
    self.activeDownload = [NSMutableData data];

    
    NSString* urlString = [NSString stringWithFormat:@"%@/expert?skillidlist=@%", ikmServerUrl, @"{11, 12}"];
    NSLog(@"Server URL: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];

    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)cancelDownload
{
    [self.connection cancel];
    self.connection = nil;
    self.activeDownload = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

// -------------------------------------------------------------------------------
//	connectionDidFinishLoading:connection
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.connection = nil;   // release our connection
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    
    NSError* jsonParsingError = nil;
    NSDictionary* skillArray = [NSJSONSerialization JSONObjectWithData:self.activeDownload options:0 error:&jsonParsingError];
    self.activeDownload = nil;
    
    if (jsonParsingError) {
        [self handleError:jsonParsingError];
    }
    else
    {
        for (NSDictionary* dict in [skillArray objectForKey:@"experts"]) {
            
            NSNumber* guid = [NSNumber numberWithInt:[[dict objectForKey:@"guid"] intValue]];
            NSString* firstname = [dict objectForKey:@"firstName"];
            NSString* lastname = [dict objectForKey:@"lastName"];
            NSString* businessUnit = [dict objectForKey:@"businessUnitName"];
            
            Expert* expert = [Expert expertWithFirstName:firstname LastName:lastname];
            expert.guid = guid;
            expert.businessUnitName = businessUnit;
            
            [self.experts addObject:expert];
            
            NSLog(@"Added: %@", [dict description]);
        }
    }
    
    [delegate expertsDidLoad:experts];
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
    
    self.connection = nil;   // release our connection
    self.activeDownload = nil;
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

@end
