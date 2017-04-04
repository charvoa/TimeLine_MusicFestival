//
//  EventManager.h
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#ifndef EventManager_h
#define EventManager_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventView.h"
#import "Place.h"
#import "TramView.h"
#import "StageView.h"
#import "DateView.h"
#import "QuartzCore/QuartzCore.h"

@protocol ClickEventDelegate <NSObject>
@optional
- (void)touchesOnStageBegan:(StageView*)stageView;
- (void)touchesOnEventBegan:(EventView*)eventView;
@end

@interface EventManager : NSObject <UIScrollViewDelegate, ChangeDateDelegate>

@property (strong) UIScrollView* view;
@property (strong) NSMutableArray *places;
@property (strong) NSMutableArray *events;
@property (strong) NSMutableArray *visibleEvents;
@property (strong) NSDate *currentDate;
@property (strong) DateView *dateView;

+ (instancetype)sharedInstanceWithView: (UIScrollView*)view withDate:(NSDate*)date;
- (void)setDelegate:(id <ClickEventDelegate>)aDelegate;
- (void) addEvent:(Event*)event;
- (void) displayEvent;
-(void) reloadEvents;
-(void) clearEvents;
- (void) addStage:(Place*)place withColor:(UIColor*)color;
- (void) updateViews:(double)xOffset withYOffset:(double)yOffset;
- (void) initStaticViews;
- (Place*)findPlaceWithName:(NSString*)name;
-(EventView*) findEventViewWithEvent:(Event*)event;
- (void) doubleTap : (UIGestureRecognizer*) sender;


@end

#endif /* EventManager_h */
