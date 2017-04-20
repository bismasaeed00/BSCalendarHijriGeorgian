//
//  BSIslamicCalendar.h
//  Islamic Calendar Example
//
//  Created by Bisma on 10/04/2017.
//  Copyright © 2017 Bisma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSIslamicCalendar;

@protocol BSIslamicCalendarDelegate <NSObject>

-(BOOL)islamicCalendar:(BSIslamicCalendar*)calendar shouldSelectDate:(NSDate*)date;
-(void)islamicCalendar:(BSIslamicCalendar*)calendar dateSelected:(NSDate*)date withSelectionArray:(NSArray*)selectionArry;

@end

@interface BSIslamicCalendar : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak) id<BSIslamicCalendarDelegate> delegate;

#pragma mark - Initializers
-(id)init;
-(id)initWithFrame:(CGRect)frame;

#pragma mark - Set properties
-(void)setShortInitials:(BOOL)isShort;
-(void)setShowIslamicMonth:(BOOL)isIslamic;
-(void)setIslamicDatesInArabicLocale:(BOOL)isArabic;


-(NSArray*)getSelectedDates;
-(BOOL)compareDate:(NSDate*)date1 withDate:(NSDate*)date2;

#pragma mark - Set Colors
-(void)setDateTextColor:(UIColor*)color;
-(void)setDateBGColor:(UIColor*)color;
-(void)setDaysNameColor:(UIColor*)color;
-(void)setSelectedDateBGColor:(UIColor*)color;
-(void)setCurrentDateTextColor:(UIColor*)color;

@end
