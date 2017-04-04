//
//  EventView.m
//  Timeline_Project
//
//  Created by Nicolas on 28/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import "EventView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface EventView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UIView *sideLineView;
@property (weak, nonatomic) IBOutlet UILabel *placeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation EventView


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

-(void) setupView:(Event*)event withBGColor:(UIColor*)color;
{
    self.event = event;
    self.sideLineView.backgroundColor = color;
    self.placeTitleLabel.textColor = UIColorFromRGB(0x95A5A6);
    self.timeLabel.textColor = UIColorFromRGB(0x95A5A6);
    
    self.placeTitleLabel.text = event.place.name;
    
    self.contentView.backgroundColor = [color colorWithAlphaComponent:0.1];
    self.contentView.layer.cornerRadius = 5.0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    NSString *startTime_str = [formatter stringFromDate:event.startDate];
    NSString *endTime_str = [formatter stringFromDate:event.endDate];

    self.timeLabel.text = [NSString stringWithFormat:@"%@ - %@", startTime_str, endTime_str];
    NSLog(@"%@", _event.artistName);
    self.eventTitle.text = _event.artistName;
}

-(void) customInit
{
    [[NSBundle mainBundle] loadNibNamed:@"EventView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    
}

@end
