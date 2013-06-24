//
//  WordStore.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 6/10/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "WordStore.h"

@interface WordStore(){

}
@end

@implementation WordStore

+(WordStore *) sharedStore{
    static WordStore * wStore = nil;
    if(!wStore){
        wStore = [[super allocWithZone:nil] init];
    }
    return wStore;
}

-(id)init{
    self = [super init];
    if(self){
        //initialize all of our values here
    }
    
    return self;
}
@end