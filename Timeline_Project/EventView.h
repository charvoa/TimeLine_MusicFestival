//
//  EventView.h
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventView : UIView

@property (retain) Event *event;

-(instancetype) initWithCoder:(NSCoder *)aDecoder;
-(instancetype) initWithFrame:(CGRect)frame;
-(void) setupView:(Event*)event withBGColor:(UIColor*)color;
-(void) customInit;

@end
