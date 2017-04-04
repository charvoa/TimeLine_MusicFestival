//
//  EventManager.m
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import "EventManager.h"

#define handle_tap(view, delegate, selector) do {\
view.userInteractionEnabled = YES;\
[view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:delegate action:selector]];\
} while(0)

static CGFloat const tramViewWidth = 160.0;
static CGFloat const tramViewHeight = 40.0;
static CGFloat const eventViewHeight = 80.0;
static CGFloat const stageViewWidth = 100.0;
static CGFloat const stageViewHeight = 80.0;
static CGFloat const dateViewWidth = 100.0;
static CGFloat const dateViewHeight = 50.0;

@interface EventManager()

@property (nonatomic, weak) id <ClickEventDelegate> delegate;

@end

@implementation EventManager {
    struct {
        unsigned int touchesOnStageBegan:1;
        unsigned int touchesOnEventBegan:1;
    } delegateRespondsTo;
}

@synthesize delegate;

- (void)setDelegate:(id <ClickEventDelegate>)aDelegate {
    NSLog(@"Set delegate before if");
    
    if (delegate != aDelegate) {
        NSLog(@"Set delegate");
        delegate = aDelegate;
        
        delegateRespondsTo.touchesOnStageBegan = [delegate respondsToSelector:@selector(touchesOnStageBegan:)];
        delegateRespondsTo.touchesOnEventBegan = [delegate respondsToSelector:@selector(touchesOnEventBegan:)];
    }
}


+ (instancetype)sharedInstanceWithView: (UIScrollView*)view withDate:(NSDate*)date
{
    static EventManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EventManager alloc] init];
        sharedInstance.view = view;
        sharedInstance.view.delegate = sharedInstance;
        sharedInstance.dateView = [[DateView alloc] initWithFrame:CGRectMake(0, 0, dateViewWidth, dateViewHeight)];
        [sharedInstance.dateView setDelegate:sharedInstance];        
        sharedInstance.currentDate = date;
        sharedInstance.places = [[NSMutableArray alloc] init];
        sharedInstance.events = [[NSMutableArray alloc] init];
        sharedInstance.visibleEvents = [[NSMutableArray alloc] init];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:sharedInstance action:@selector(doubleTap:)];
        tap.numberOfTapsRequired = 2;
        tap.numberOfTouchesRequired = 1;
        [sharedInstance.view addGestureRecognizer:tap];
        
        
        [sharedInstance initStaticViews];
    });
    return sharedInstance;
}

- (void) doubleTap : (UIGestureRecognizer*) sender
{
    [self scrollToFirstEvent];
}

// SCROLL VIEW DELEGATE
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateViews:scrollView.contentOffset.x withYOffset:scrollView.contentOffset.y];
}

// CHANGEDATEDELEGATE
- (void)didMoveToPreviousDate {
    NSLog(@"MOVE TO PREV DATE DELEAGTE");

    NSDate *newDate = [_currentDate dateByAddingDays:-1];
    
    _currentDate = newDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"Todays date is %@ | ",[formatter stringFromDate:_currentDate]);
    [_dateView setupView:newDate];
    [self reloadEvents];
}

- (void)didMoveToNextDate {
    NSLog(@"MOVE TO NEXT DATE DELEAGTE");
    
    NSDate *newDate = [_currentDate dateByAddingDays:1];
    
    _currentDate = newDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"Todays date is %@ |",[formatter stringFromDate:_currentDate]);

    [_dateView setupView:newDate];
    [self reloadEvents];
}


// DESIGN
- (void) updateViews:(double)xOffset withYOffset:(double)yOffset {
    for (UIView *v in _view.subviews) {
        if ([v isKindOfClass:[StageView class]]) {
            CGRect viewFrame = v.frame;
            viewFrame.origin.x = MAX(0, xOffset);
            v.frame = viewFrame;
        } else if ([v isKindOfClass:[TramView class]]) {
            CGRect viewFrame = v.frame;
            viewFrame.origin.y = MAX(0, yOffset);
            v.frame = viewFrame;
        } else if ([v isKindOfClass:[DateView class]]) {
            CGRect viewFrame = v.frame;
            viewFrame.origin.y = MAX(0, yOffset);
            viewFrame.origin.x = MAX(0, xOffset);
            v.frame = viewFrame;
        }
    }
}

- (void) initStaticViews
{
    // HOURS
    TramView *tram;
    
    for (int i = 0; i < 24; i++) {
        
        tram = [[TramView alloc] initWithFrame:CGRectMake(0+dateViewWidth+(tramViewWidth*i), 0, tramViewWidth, tramViewHeight)];
        [tram setupView:[NSString stringWithFormat:@"%dh",i] withLineColor:[UIColor blackColor]];
        tram.layer.zPosition = 3000;

        [self.view addSubview:tram];
    }
    
    // DATE
    
    [_dateView setupView:_currentDate];
    _dateView.layer.zPosition = 3000;

    
    
    [_view addSubview:_dateView];
}

- (void) addStage:(Place*)place withColor:(UIColor*)color {
    StageView *stageView;
    
    stageView = [[StageView alloc] initWithFrame:CGRectMake(0, place.placeId*stageViewHeight + dateViewHeight, stageViewWidth, stageViewHeight)];
    [stageView setupView:place withBGColor:color];
    
    stageView.layer.zPosition = 3000;
    
    [_places addObject:place];
    
    handle_tap(stageView, self, @selector(stageViewClick:));
    
    [_view addSubview:stageView];
}

-(void) stageViewClick:(UITapGestureRecognizer *)recognizer {
    StageView *view = (StageView*)recognizer.view;
    
    //NSString *string = [NSString stringWithFormat:@"Clicked on stage %@", view.place.name];
    
    [self.delegate touchesOnStageBegan:view];
}

-(void) eventViewClick:(UITapGestureRecognizer *)recognizer {
    
    EventView *view = (EventView*)recognizer.view;
    
    //NSString *string = [NSString stringWithFormat:@"Clicked on event %@", view.event.artistName];
    
    [self.delegate touchesOnEventBegan:view];
}

- (void) addEvent:(Event*)event
{
    [_events addObject:event];
}

-(void) clearEvents {
    for (UIView *v in _view.subviews) {
        if ([v isKindOfClass:[EventView class]]) {
            [v removeFromSuperview];
        }
    }
    //_view.contentSize = CGSizeMake(4000, [_places count] * stageViewHeight);

}

-(void) reloadEvents {
    [_visibleEvents removeAllObjects];
    [self displayEvent];
    [self scrollToFirstEvent];
}

- (void) displayEvent
{
    if (!_view) {
        assert(@"You need to setup the view first in order to make the EventManager work properly");
    }
    
    [self clearEvents];

    for (Event *event in _events) {
        
        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        Boolean sameDay = [currentCalendar isDate:_currentDate inSameDayAsDate:event.startDate];
        if (sameDay) {
            
            // SIZE OF VIEW
            
            NSInteger baseMinutes = 60;     // 60 = 160
            CGFloat baseValue = 160;        // diff_minutes = newSize
            
            NSTimeInterval interval = [event.endDate timeIntervalSinceDate:event.startDate];
            
            NSInteger diff_minutes = interval/baseMinutes;
            
            CGFloat newSize = diff_minutes*baseValue/baseMinutes;
            
            NSInteger startHour = event.startDate.hour;
            NSInteger startMinutes = event.startDate.minute;
            
            
            CGFloat x = stageViewWidth + (startHour)*tramViewWidth + startMinutes*(160/baseMinutes);
            
            // SIZE OF VIEW ^^^^^^^^^
            
            EventView* eView = [[EventView alloc] initWithFrame: CGRectMake(x, event.place.placeId*stageViewHeight+dateViewHeight, newSize, eventViewHeight)];
            
            
            [eView setupView:event withBGColor:event.bgColor];
            
            handle_tap(eView, self, @selector(eventViewClick:));
            [self.visibleEvents addObject:eView];
            [self.view addSubview:eView];
        } else {
            //NSLog(@"You can't add this event because it's not happening today !");
        }
    }
}

- (void) scrollToFirstEvent {

    Event *firstEvent;
    
    NSTimeInterval save = 86399;
    
    for (Event *e in _events) {
        NSTimeInterval interval = [e.startDate timeIntervalSinceDate:_currentDate];
        [e printInfo];
        NSLog(@"%f", interval);

        if (interval < save && interval >= 0) {
            firstEvent = e;
        }
    }
    
    @try {
        CGRect firstEvent_rect = [self findEventViewWithEvent:firstEvent].frame;
        
        [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            _view.contentOffset = CGPointMake(firstEvent_rect.origin.x - stageViewWidth*2, 0);
        } completion:NULL];
    }
    @catch (NSException *e) {
        NSLog(@"No event to display for the day");
    }
    
    //CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    //CGFloat firstEvent_rectY = screenHeight < firstEvent_rect.origin.y + eventViewHeight ? firstEvent_rect.origin.y : 0;

    
}

-(EventView*) findEventViewWithEvent:(Event*)event {
    for (EventView *eV in _visibleEvents) {
        if (eV.event == event) {
            return eV;
        }
    }
    NSException* myException = [NSException
                                exceptionWithName:@"EventViewNotFound"
                                reason:@"The Event you are looking for doesn't exist"
                                userInfo:nil];
    @throw myException;
}

-(Place*)findPlaceWithName:(NSString*)name
{
    for (Place* p in _places) {
        if ([p.name isEqualToString:name]) {
            return p;
        }
    }
    
    NSException* myException = [NSException
                                exceptionWithName:@"PlaceNotFound"
                                reason:@"The Place you are looking for doesn't exist"
                                userInfo:nil];
    @throw myException;
}

@end
