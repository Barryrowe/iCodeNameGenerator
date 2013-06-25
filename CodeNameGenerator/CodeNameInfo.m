//
//  CodeNameInfo.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 6/24/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "CodeNameInfo.h"

@implementation CodeNameInfo

@synthesize firstWord;
@synthesize secondWord;
@synthesize summary;
@synthesize repoUrl;


-(id)initWithFirstWord:(NSString *)fw SecondWord:(NSString *)sw Summary:(NSString *)smry AndRepoUrl:(NSString *)rurl{
    self = [super init];
    if(self) {
        firstWord = fw;
        secondWord = sw;
        summary = smry;
        repoUrl = rurl;
    }
    return self;
}

-(NSString *)displayName{
    return [NSString stringWithFormat:@"%@ %@", firstWord, secondWord];
}
@end
