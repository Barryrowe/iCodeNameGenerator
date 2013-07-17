//
//  GHRepository.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 7/16/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "GHRepository.h"

@implementation GHRepository

- (id) initWithNSDictionary:(NSDictionary *)dictFromJSON{
    self = [super init];
    if(self){
        self.repoType = [dictFromJSON valueForKeyPath:@"type"];
        self.repoUsername = [dictFromJSON valueForKeyPath:@"username"];
        self.repoName = [dictFromJSON valueForKeyPath:@"name"];
        self.repoOwner = [dictFromJSON valueForKeyPath:@"owner"];
        self.repoHomepage = [dictFromJSON valueForKeyPath:@"homepage"];
        self.repoDescription = [dictFromJSON valueForKeyPath:@"description"];
        self.repoUrl = [dictFromJSON valueForKeyPath:@"url"];
    }
    
    return self;
}

+ (NSArray *) reposFromJson:(NSData *)jsonData{
    
    NSError *parseError;
    id parsedObj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:0
                                                     error:&parseError];
    if(!parsedObj){
        NSLog(@"Error parsing JSON: %@", parseError);
        return nil;
    }
    
    if([parsedObj isKindOfClass:[NSArray class]]){
        NSArray *parsedRepos = (NSArray *)parsedObj;
        NSMutableArray *ghRepos = [[NSMutableArray alloc] initWithCapacity:[parsedRepos count]];
        
        for(id repo in parsedRepos){
            if([repo isKindOfClass:[NSDictionary class]]){
                GHRepository *newRepo = [[GHRepository alloc] initWithNSDictionary:repo];
                [ghRepos addObject:newRepo];
            }
        }
        return ghRepos;
    }
    return nil;

}
@end
