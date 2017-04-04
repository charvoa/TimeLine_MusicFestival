//
//  DateView.m
//  Timeline_Project
//
//  Created by Nicolas on 30/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import "DateView.h"

@interface DateView ()

@property (nonatomic, weak) id <ChangeDateDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;


@end

@implementation DateView {
    struct {
        unsigned int didMoveToNextDate:1;
        unsigned int didMoveToPreviousDate:1;
    } delegateRespondsTo;
}

@synthesize delegate;

- (void)setDelegate:(id <ChangeDateDelegate>)aDelegate {
    NSLog(@"Set delegate before if");

    if (delegate != aDelegate) {
        NSLog(@"Set delegate");
        delegate = aDelegate;
        
        delegateRespondsTo.didMoveToPreviousDate = [delegate respondsToSelector:@selector(didMoveToPreviousDate)];
        delegateRespondsTo.didMoveToNextDate = [delegate respondsToSelector:@selector(didMoveToNextDate)];
    }
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

-(void) setupView:(NSDate*)date
{
    // SETUP OF DATE DISPLAY
    NSString *day = [NSString stringWithFormat: @"%ld", (long)date.day];
    NSString *month = [self getMonthToString:date.month];
    self.dateLabel.text = [NSString stringWithFormat: @"%@ %@", day, month];
    [self.leftButton setTitle:@"<" forState:UIControlStateNormal];
    [self.rightButton setTitle:@">" forState:UIControlStateNormal];


}

-(NSString*) getMonthToString: (NSInteger)month {
    NSString *month_Str;
    switch (month) {
        case 1:
            month_Str = @"Jan.";
            break;
        case 2:
            month_Str = @"Fev.";
            break;
        case 3:
            month_Str = @"Mar.";
            break;
        case 4:
            month_Str = @"Avr.";
            break;
        case 5:
            month_Str = @"Mai.";
            break;
        case 6:
            month_Str = @"Jui.";
            break;
        case 7:
            month_Str = @"Juil.";
            break;
        case 8:
            month_Str = @"Aou.";
            break;
        case 9:
            month_Str = @"Sep.";
            break;
        case 10:
            month_Str = @"Oct.";
            break;
        case 11:
            month_Str = @"Nov.";
            break;
        case 12:
            month_Str = @"Dec.";
            break;
        default:
            break;
    }
    
    return month_Str;
}

- (IBAction)rightButtonAction:(id)sender {
    NSLog(@"MOVE TO NEXT DATE");
    if (self.delegate) {
        NSLog(@"DELEGATE EXIST");
        
    }

    [self.delegate didMoveToNextDate];
}
- (IBAction)leftButtonAction:(id)sender {
    
    NSLog(@"MOVE TO PREV DATE");
    if (self.delegate) {
        NSLog(@"DELEGATE EXIST");

    }

    [self.delegate didMoveToPreviousDate];
}

-(void) customInit
{
    [[NSBundle mainBundle] loadNibNamed:@"DateView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}

@end
