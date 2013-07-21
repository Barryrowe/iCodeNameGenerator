//
//  GHRepository.h
//  CodeNameGenerator
//
//  Created by Barry Rowe on 7/16/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
  Example JSON from Github API V3 for Repository Search. This result was
    returned from the following urL:
  https://api.github.com/legacy/repos/search/iCodeNameGenerator
 
 {
    "repositories": [
        {
         "type": "repo",
         "username": "Barryrowe",
         "name": "iCodeNameGenerator",
         "owner": "Barryrowe",
         "homepage": null,
         "description": "This is a simple Code Name generatore app for iOS",
         "language": "Objective-C",
         "watchers": 1,
         "followers": 1,
         "forks": 0,
         "size": 272,
         "open_issues": 0,
         "score": 11.387688,
         "has_downloads": true,
         "has_issues": true,
         "has_wiki": true,
         "fork": false,
         "private": false,
         "url": "https://github.com/Barryrowe/iCodeNameGenerator",
         "created": "2013-04-27T04:01:30Z",
         "created_at": "2013-04-27T04:01:30Z",
         "pushed_at": "2013-07-03T01:22:37Z",
         "pushed": "2013-07-03T01:22:37Z"
        }
    ]
 }
*/


@interface GHRepository : NSObject

@property (nonatomic, copy) NSString *repoType;
@property (nonatomic, copy) NSString *repoUsername;
@property (nonatomic, copy) NSString *repoName;
@property (nonatomic, copy) NSString *repoOwner;
@property (nonatomic, copy) NSString *repoHomepage;
@property (nonatomic, copy) NSString *repoDescription;
@property (nonatomic, copy) NSString *repoUrl;
//
//Initializers
//
- (id) initWithNSDictionary:(NSDictionary *) dictFromJSON;
//-----

//
//Class Methods
//
+ (NSArray *) reposFromJson:(NSData *)jsonData;
//-----
@end
