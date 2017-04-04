//
//  StageView.m
//  Timeline_Project
//
//  Created by Nicolas on 29/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import "StageView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface StageView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *stageTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *sideLineView;


@end

@implementation StageView


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

-(void) setupView:(Place*)place withBGColor:(UIColor*)color
{
    _place = place;
    self.stageTitleLabel.text = place.name;
    self.stageTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.contentView.layer.borderWidth = 1.0;
    self.contentView.layer.borderColor = UIColorFromRGB(0xF7F7F7).CGColor;
    self.sideLineView.backgroundColor = color;
}

-(void) customInit
{
    [[NSBundle mainBundle] loadNibNamed:@"StageView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}

@end
