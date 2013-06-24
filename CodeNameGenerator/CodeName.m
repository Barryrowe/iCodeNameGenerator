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
@synthesize firstWord;
@synthesize secondWord;
@synthesize summary;
@synthesize repoUrl;


-(id)initWithFirstWord:(NSString *)wordOne AndSecondWord:(NSString *)wordTwo{
    self = [super init];
    if(self){
        [self setFirstWord:wordOne];
        self.secondWord = wordTwo;
        self.name = [NSString stringWithFormat:@"%@ %@", firstWord, secondWord];
    }
    return self;
}

-(NSString *)description{
    return [self name];
}
@end
