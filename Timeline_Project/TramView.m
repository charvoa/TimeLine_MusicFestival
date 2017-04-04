//
//  TramView.m
//  Timeline_Project
//
//  Created by Nicolas on 29/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import "TramView.h"

@interface TramView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation TramView


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

-(void) setupView:(NSString*)hour withLineColor:(UIColor*)color
{
    self.hourLabel.text = hour;
    self.lineView.backgroundColor = color;
}

-(void) customInit
{
    [[NSBundle mainBundle] loadNibNamed:@"TramView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}

@end

