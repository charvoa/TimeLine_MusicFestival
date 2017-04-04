//
//  ViewController.m
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *eventView;

@property (weak, nonatomic) IBOutlet UIView *crossView;
@end

@implementation ViewController
{
    NSArray *stageArray;
    EventManager *eventManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _eventView.delegate = self;
    NSDate *dateOfToday = [[NSDate alloc] init];

    eventManager = [EventManager sharedInstanceWithView:_eventView withDate:dateOfToday];
    [eventManager setDelegate:self];
    
    
    stageArray = [NSArray arrayWithObjects:@"SCENE GLENMOR", @"SCENE KEROUAC", @"SCENE GRALL", @"SCENE GWERNIG", @"SCENE 5", nil];
    
    // ADDING STAGES
    for (NSUInteger i = 0; i < [stageArray count]; i++) {
        Place *place = [[Place alloc] initWithName:[stageArray objectAtIndex:i] withOrder:(int)i];
        [eventManager addStage:place withColor:[UIColor brownColor]];
        
    }
    
    // =======================================================================================
    
    // CREATING EVENTS AT THE RIGHT PLACE :
    
    Place *p = [eventManager findPlaceWithName:@"SCENE GRALL"]; // CATCH ERROR IF YOU WANT TO
    
    Event *newEvent = [[Event alloc] initWithArtistName:@"M" withPlace:p withStartDate:[dateOfToday dateByAddingHours:-1] withEndDate:[dateOfToday dateByAddingHours:2] withBGColor:[UIColor yellowColor]];
    
    [eventManager addEvent:newEvent];
    
    // Another Event Another place :
    Place *anotherPlace = [eventManager findPlaceWithName:@"SCENE 5"]; // CATCH ERROR IF YOU WANT TO
    
    Event *anotherEvent = [[Event alloc] initWithArtistName:@"Eminem" withPlace:anotherPlace withStartDate:dateOfToday withEndDate:[dateOfToday dateByAddingHours:2] withBGColor:[UIColor blueColor]];
    
    [eventManager addEvent:anotherEvent];
    
    // CREATE AN EVENT FOR THE DAY AFTER :
    
    Place *otherPlace = [eventManager findPlaceWithName:@"SCENE KEROUAC"]; // CATCH ERROR IF YOU WANT TO
    
    NSDate *dateOfTom = [[[NSDate alloc] init] dateByAddingDays:1];
    
    Event *otherEvent = [[Event alloc] initWithArtistName:@"Big Flo" withPlace:otherPlace withStartDate:dateOfTom withEndDate:[dateOfTom dateByAddingHours:2] withBGColor:[UIColor yellowColor]];
    [eventManager addEvent:otherEvent];

    // RELOAD IN ORDER TO DISPLAY
    [eventManager reloadEvents];

    
    // UPDATING SCROLL INTERFACE
    self.eventView.contentSize = CGSizeMake(4000, [stageArray count] * 80 + 50);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// DELEGATE CLICK EVENT

-(void) touchesOnEventBegan:(EventView *)eventView {
    NSString *str = [NSString stringWithFormat:@"Clicked on event %@", eventView.event.artistName];
    
    if ([UIAlertController class])
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Touch" message:str preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Touch" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }

}

-(void)touchesOnStageBegan:(StageView *)stageView {
    NSString *str = [NSString stringWithFormat:@"Clicked on stage %@", stageView.place.name];
    
    if ([UIAlertController class])
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Touch" message:str preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Touch" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }

}


@end
