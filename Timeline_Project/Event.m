//
//  Event.m
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import "Event.h"

@implementation Event {
    
}

-(void) perform {
    NSLog(@"Hey my name is %@ I hope you're doing great tonight", self.artistName);
    
}

- (id)initWithArtistName:(NSString *)aName withPlace:(Place*)place withStartDate:(NSDate*)startDate withEndDate:(NSDate*)endDate withBGColor:(UIColor*)bgColor {
    
    self = [super init];
    if (self) {
        // Any custom setup work goes here
        _artistName = [aName copy];
        _place = place;
        _startDate = startDate;
        _endDate = endDate;
        _bgColor = bgColor;
    }
    return self;
}

-(void) printInfo {
    NSLog(@"\n///// EVENT /////\n %@ %@ \n/////       /////", _artistName, _place.name);
}

- (id)init {
    // Forward to the "designated" initialization method
    return [self initWithArtistName:@"Artist" withPlace:[[Place alloc] initWithName:@"Stage" withOrder:0] withStartDate:[[NSDate alloc] init] withEndDate:[[NSDate alloc] init] withBGColor:[UIColor yellowColor]];
}

@end
