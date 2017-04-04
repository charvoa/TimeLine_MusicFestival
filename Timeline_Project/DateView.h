//
//  DateView.h
//  Timeline_Project
//
//  Created by Nicolas on 30/03/2017.
//  Copyright © 2017 Nicolas Charvoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateTools.h"

@protocol ChangeDateDelegate <NSObject>
@optional
- (void)didMoveToNextDate;
- (void)didMoveToPreviousDate;
@end

@interface DateView : UIView


-(instancetype) initWithCoder:(NSCoder *)aDecoder;
-(instancetype) initWithFrame:(CGRect)frame;
-(void) setupView:(NSDate*)date;
-(NSString*) getMonthToString: (NSInteger)month;
-(void) customInit;

- (void)setDelegate:(id <ChangeDateDelegate>)aDelegate;

@end

