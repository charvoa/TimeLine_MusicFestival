//
//  Place.m
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import "Place.h"


@implementation Place {
    
}


- (id)initWithName:(NSString *)aName withOrder:(int)order
{
    self = [super init];
    if (self) {
        // Any custom setup work goes here
        _name = aName;
        _placeId = order;
        NSLog(@"%d", _placeId);
    }
    return self;
}

- (id)init {
    // Forward to the "designated" initialization method
    return [self initWithName:@"Artist" withOrder:0];
}

@end
