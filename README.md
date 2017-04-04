# Timeline Music Festival

This project creates a fully customizable Timeline in order to be used by Music Festivals.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Installing

I will create a simple Framework when I will have more time, but for now here is a simple solution in order to install this "library" :

- Download the zip archive / Clone the repo.
- Create a new project in Xcode.
- 'Add files to ...'
- Select all the files contained in "Timeline_Project", except 'ViewController.h/m', 'AppDelegate.h/m', 'main.m' and 'Info.plist'.
- Drag & Drop those files in your new projects. Copy item if needed and add them to your selected target.

## Create a simple view :

ViewController.m :

```
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

    // We setup the UIScrollViewDelegate =>
    _eventView.delegate = self;

    /* We setup the eventManager with the UIScrollView and the current date (the first date that will be displayed on the screen) => */
    NSDate *dateOfToday = [[NSDate alloc] init];
    eventManager = [EventManager sharedInstanceWithView:_eventView withDate:dateOfToday];

    // Advanced part, we setup the delegate. We'll see after why we need delegates (or not ...) =>
    [eventManager setDelegate:self];

    // We add fake stages =>

    stageArray = [NSArray arrayWithObjects:@"SCENE GLENMOR", @"SCENE KEROUAC", @"SCENE GRALL", @"SCENE GWERNIG", @"SCENE 5", nil];

    for (NSUInteger i = 0; i < [stageArray count]; i++) {
        Place *place = [[Place alloc] initWithName:[stageArray objectAtIndex:i] withOrder:(int)i];
        [eventManager addStage:place withColor:[UIColor brownColor]];

    }

    /* ========================== EVENT CREATION ========================== */

    // First we look for the Place object with its name =>
    Place *p = [eventManager findPlaceWithName:@"SCENE GRALL"]; // CATCH ERROR IF YOU WANT TO

    // Then we create the event at the right place, and we setup its start time and end time =>
    Event *newEvent = [[Event alloc] initWithArtistName:@"M" withPlace:p withStartDate:[dateOfToday dateByAddingHours:-1] withEndDate:[dateOfToday dateByAddingHours:2] withBGColor:[UIColor yellowColor]];

    [eventManager addEvent:newEvent];

    // We reload the view in order to see the events =>
    [eventManager reloadEvents];

    /* VERY IMPORTANT => We have to update manually the size of the content inside the scrollview, or it won't scroll.
        Simple maths will help you in this case.
    */
    self.eventView.contentSize = CGSizeMake(4000, [stageArray count] * 80 + 50);
}
```

Explain how to run the automated tests for this system

## Authors

* **Nicolas Charvoz** - [charvoa](https://github.com/PurpleBooth)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
