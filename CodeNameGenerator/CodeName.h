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
@property (nonatomic, retain) NSString * firstWord;
@property (nonatomic, retain) NSString * secondWord;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * repoUrl;

@end
