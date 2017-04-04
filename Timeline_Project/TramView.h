//
//  TramView.h
//  Timeline_Project
//
//  Created by Nicolas on 29/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TramView : UIView


-(instancetype) initWithCoder:(NSCoder *)aDecoder;
-(instancetype) initWithFrame:(CGRect)frame;
-(void) setupView:(NSString*)hour withLineColor:(UIColor*)color;
-(void) customInit;

@end
