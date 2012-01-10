//
//  ExpertDownloader.h
//  IKM Database
//
//  Created by Michael Mühlebach on 1/5/12.
//  Copyright (c) 2012 Zühlke Engineering AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Expert;
@class RootViewController;

@protocol ExpertsDownloaderDelegate;

@interface ExpertsDownloader : NSObject
{
    
}

@property (nonatomic, retain) NSMutableArray *experts;
@property (nonatomic, assign) id <ExpertsDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSArray* queries;

- (void)startDownload;
- (void)cancelDownload;
- (void)handleError:(NSError *)error;

@end

@protocol ExpertsDownloaderDelegate 

- (void)expertsDidLoad:(NSArray *)experts;

@end
