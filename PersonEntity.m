//
//  PersonEntity.m
//  HumanStorage
//
//  Created by Marvin Labrador on 6/4/15.
//  Copyright (c) 2015 Marvin Labrador. All rights reserved.
//

#import "PersonEntity.h"

@implementation PersonEntity

- (void)dealloc
{
    self.lNameString = nil;
    self.fNameString = nil;
    [super dealloc];
}

@end
