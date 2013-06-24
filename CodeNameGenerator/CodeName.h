//
//  CodeName.h
//  CodeNameGenerator
//
//  Created by Barry Rowe on 6/10/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CodeName : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * codeNameFirstWord;
@property (nonatomic, retain) NSString * codeNameSecondWord;
@property (nonatomic, retain) NSString * codeNameSummary;
@property (nonatomic, retain) NSString * codeNameRepoUrl;

-(id)initWithFirstWord:(NSString *)firstWord AndSecondWord:(NSString *)secondWord;
-(id)initWithFirstWord:(NSString *)firstWord SecondWord:(NSString *)secondWord Summary:(NSString *)summary AndRepoUrl:(NSString *)repoUrl;
@end
