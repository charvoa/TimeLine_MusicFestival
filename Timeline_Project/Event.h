//
//  Event.h
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#ifndef Event_h
#define Event_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Place.h"

@interface Event : NSObject {
    
}

@property (copy) NSString* artistName;
@property (retain) Place* place;
@property (retain) NSDate* startDate;
@property (retain) NSDate* endDate;
@property (retain) UIColor* bgColor;


-(void)perform;
- (id)initWithArtistName:(NSString *)aName withPlace:(Place*)place withStartDate:(NSDate*)startDate withEndDate:(NSDate*)endDate withBGColor:(UIColor*)bgColor;
- (id)init;
-(void) printInfo;

@end

#endif /* Event_h */
