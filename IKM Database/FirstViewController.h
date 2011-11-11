//
//  FirstViewController.h
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expert.h"

@interface FirstViewController : UIViewController

@property (strong, nonatomic) Expert* expert;
@property (assign) IBOutlet UILabel* expertName;
@property (assign) IBOutlet UILabel* careerLevel;
@property (assign) IBOutlet UILabel* businessUnit;
@property (assign) IBOutlet UIImageView* picture;

@end
