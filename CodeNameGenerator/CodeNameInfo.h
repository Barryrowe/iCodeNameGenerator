//
//  CodeNameInfo.h
//  CodeNameGenerator
//
//  Created by Barry Rowe on 6/24/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeNameInfo : NSObject

@property (nonatomic, strong) NSString * firstWord;
@property (nonatomic, strong) NSString * secondWord;
@property (nonatomic, strong) NSString * summary;
@property (nonatomic, strong) NSString * repoUrl;

-(id)initWithFirstWord:(NSString *)fw SecondWord:(NSString *)sw Summary:(NSString *)smry AndRepoUrl:(NSString *)rurl;
-(NSString *) displayName;
@end
