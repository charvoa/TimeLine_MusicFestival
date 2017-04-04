//
//  StageView.h
//  Timeline_Project
//
//  Created by Nicolas on 29/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface StageView : UIView

@property (strong) Place *place;

-(instancetype) initWithCoder:(NSCoder *)aDecoder;
-(instancetype) initWithFrame:(CGRect)frame;
-(void) setupView:(Place*)place withBGColor:(UIColor*)color;
-(void) customInit;

@end
