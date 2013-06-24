//
//  CodeName.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 6/10/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "CodeName.h"


@implementation CodeName

@synthesize name;
@synthesize codeNameFirstWord;
@synthesize codeNameSecondWord;
@synthesize codeNameSummary;
@synthesize codeNameRepoUrl;


-(id)initWithFirstWord:(NSString *)firstWord AndSecondWord:(NSString *)secondWord{
    self = [super init];
    if(self){
        [self setCodeNameFirstWord:firstWord];
        [self setCodeNameSecondWord:secondWord];
        self.name = [NSString stringWithFormat:@"%@ %@", firstWord, secondWord];
    }
    return self;
}

-(id)initWithFirstWord:(NSString *)firstWord SecondWord:(NSString *)secondWord Summary:(NSString *)summary AndRepoUrl:(NSString *)repoUrl{
    self = [super init];
    if(self){
        [self setCodeNameFirstWord:firstWord];
        [self setCodeNameSecondWord:secondWord];
        [self setCodeNameSummary:summary];
        [self setCodeNameRepoUrl:repoUrl];
        self.name = [NSString stringWithFormat:@"%@ %@", codeNameFirstWord, codeNameSecondWord];
    }
    return self;
}

-(NSString *)description{
    return [self name];
}
@end
