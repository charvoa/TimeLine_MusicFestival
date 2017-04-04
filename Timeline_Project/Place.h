//
//  Place.h
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#ifndef Place_h
#define Place_h

#import <Foundation/Foundation.h>

@interface Place : NSObject {
    
}


@property (retain) NSString *name;
@property int placeId;

- (id)initWithName:(NSString *)aName withOrder:(int)order;
- (id)init;


@end

#endif /* Place_h */
